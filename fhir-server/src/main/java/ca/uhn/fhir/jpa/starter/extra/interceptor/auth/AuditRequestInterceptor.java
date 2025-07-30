package ca.uhn.fhir.jpa.starter.extra.interceptor.auth;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Map;

import org.hl7.fhir.r4.model.AuditEvent;
import org.hl7.fhir.r4.model.Coding;
import org.hl7.fhir.r4.model.Reference;
import org.hl7.fhir.r4.model.StringType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.interceptor.api.Hook;
import ca.uhn.fhir.interceptor.api.Interceptor;
import ca.uhn.fhir.interceptor.api.Pointcut;
import ca.uhn.fhir.jpa.api.dao.DaoRegistry;
import ca.uhn.fhir.jpa.api.dao.IFhirResourceDao;
import ca.uhn.fhir.jpa.starter.extra.service.util.JwtUtil;
import ca.uhn.fhir.rest.api.server.RequestDetails;
import jakarta.servlet.http.HttpServletRequest;

@Component
@Interceptor
public class AuditRequestInterceptor {

    private static final Logger logger = LoggerFactory.getLogger(AuditRequestInterceptor.class);

    @Value("${AUDIT_SERVER_ENDPOINT:http://localhost:5000/audit-event}")
    private String AUDIT_ENDPOINT;

    @Autowired
    private FhirContext fhirContext;
    
    @Autowired
    private DaoRegistry daoRegistry;
    
    private final RestTemplate restTemplate = new RestTemplate();

    // Changed to SERVER_INCOMING_REQUEST_POST_PROCESSED for better reliability
    @Hook(Pointcut.SERVER_INCOMING_REQUEST_POST_PROCESSED)
    public void auditRequest(RequestDetails theRequestDetails, HttpServletRequest theRequest) {
        
        // Add null checks
        if (theRequestDetails == null) {
            logger.warn("RequestDetails is null, skipping audit event creation");
            return;
        }
        
        if (theRequest == null) {
            logger.warn("HttpServletRequest is null, skipping audit event creation");
            return;
        }
        
        try {
            String endpoint = getFullRequestUrl(theRequestDetails, theRequest);
            String headers = extractRequestHeaders(theRequest);
            String body = extractRequestBody(theRequest);
            int bodyLength = body != null ? body.length() : 0;
            String params = extractQueryParameters(theRequest);
            String time = new Date().toString();
            String app = theRequest.getHeader("User-Agent");
            String ip = getClientIpAddress(theRequest);
            String authHeader = theRequest.getHeader("Authorization");
            Map<String, Object> claims = JwtUtil.parseJwt(authHeader);
            String userType = JwtUtil.getUserType(claims);
            String userId = JwtUtil.getUserId(claims);
            String scopes = JwtUtil.getScopes(claims);
            if (userType.equals("unknown")) userType = "unknown (token missing or invalid)";
            if (userId.equals("unknown")) userId = "unknown (token missing or invalid)";
            if (scopes.equals("no_scope")) scopes = "no_scope (token missing or invalid)";
            // Structured log line (JSON-like)
            logger.info("AUDIT_REQUEST | time={} | endpoint={} | headers={} | bodyLength={} | params={} | app={} | ip={} | userType={} | userId={} | scopes={}",
                time, endpoint, headers, bodyLength, params, app, ip, userType, userId, scopes);

            AuditEvent auditEvent = createAuditEvent(theRequestDetails, theRequest);
            // Additional check before saving and logging from AuditEvent
            if (auditEvent != null) {
                // --- Extracting and Logging Information from the AuditEvent ---

                String auditTimestamp = null;

                String eventTypeDisplay = auditEvent.hasType() && auditEvent.getType().hasDisplay() ?
                                            auditEvent.getType().getDisplay() : "N/A";
                String action = auditEvent.hasAction() ? auditEvent.getAction().toCode() : "N/A";
                String outcome = auditEvent.hasOutcome() ? auditEvent.getOutcome().toCode() : "N/A";


                String requesterIp = "N/A";
                String clientApplication = "N/A";
                String authenticatedUserAltId = "N/A"; // This is where Keycloak user ID would typically go

                if (auditEvent.hasAgent()) {
                    for (AuditEvent.AuditEventAgentComponent agent : auditEvent.getAgent()) {
                        if (agent.getRequestor()) { // Find the requestor agent
                            if (agent.hasNetwork() && agent.getNetwork().hasAddress()) {
                                requesterIp = agent.getNetwork().getAddress();
                            }
                            if (agent.hasWho() && agent.getWho().hasDisplay()) {
                                // Extract user agent from the 'who.display' if it's formatted as "Client IP: ..., User-Agent: ..."
                                String display = agent.getWho().getDisplay();
                                int userAgentIdx = display.indexOf("User-Agent: ");
                                if (userAgentIdx != -1) {
                                    clientApplication = display.substring(userAgentIdx + "User-Agent: ".length());
                                }
                            }
                            if (agent.hasAltId()) {
                                authenticatedUserAltId = agent.getAltId();
                            }
                            break; // Assuming one requestor agent for simplicity
                        }
                    }
                }

                String requestUrl = "N/A";
                String httpMethod = "N/A";
                String resourceType = "N/A";
                String resourceId = "N/A";

                if (auditEvent.hasEntity()) {
                    for (AuditEvent.AuditEventEntityComponent entity : auditEvent.getEntity()) {
                        if (entity.hasDetail()) {
                            for (AuditEvent.AuditEventEntityDetailComponent detail : entity.getDetail()) {
                                if ("URL".equals(detail.getType()) && detail.hasValueStringType()) {
                                    requestUrl = detail.getValueStringType().getValue();
                                } else if ("HTTP Method".equals(detail.getType()) && detail.hasValueStringType()) {
                                    httpMethod = detail.getValueStringType().getValue();
                                } else if ("Resource Type".equals(detail.getType()) && detail.hasValueStringType()) {
                                    resourceType = detail.getValueStringType().getValue();
                                } else if ("Resource ID".equals(detail.getType()) && detail.hasValueStringType()) {
                                    resourceId = detail.getValueStringType().getValue();
                                }
                            }
                        }
                    }
                }


                logger.info("--- FHIR Audit Event Generated ---");
                logger.info("  Recorded At: {}", auditTimestamp);
                logger.info("  Event Type: {} (Action: {}, Outcome: {})", eventTypeDisplay, action, outcome);
                logger.info("  Request: {} {}", httpMethod, requestUrl);
                logger.info("  Accessed Resource: {}/{}", resourceType, resourceId); // Will show N/A for metadata or search
                logger.info("  Requester IP: {}", requesterIp);
                logger.info("  Client Application: {}", clientApplication);
                logger.info("  Authenticated User (AltId): {}", authenticatedUserAltId);
                logger.info("----------------------------------");
            }

            // Additional check before saving
            if (auditEvent != null) {
                // Save the AuditEvent resource to FHIR database
                IFhirResourceDao<AuditEvent> auditEventDao = daoRegistry.getResourceDao(AuditEvent.class);
                auditEventDao.create(auditEvent, theRequestDetails);
                logger.info("Audit event created successfully for request: {}", theRequestDetails.getRequestPath());
            } 
        } catch (Exception e) {
            // Improved error logging
            logger.error("Failed to create audit event for request: {} - Error: {}", 
                        theRequestDetails != null ? theRequestDetails.getRequestPath() : "unknown", 
                        e.getMessage(), e);
        }
    }

    private AuditEvent createAuditEvent(RequestDetails requestDetails, HttpServletRequest request) {
        
        // Additional null checks in createAuditEvent
        if (requestDetails == null) {
            logger.warn("RequestDetails is null in createAuditEvent");
            return null;
        }
        
        if (requestDetails.getRequestType() == null) {
            logger.warn("RequestType is null in RequestDetails");
            return null;
        }
        
        AuditEvent auditEvent = new AuditEvent();
        
        // 1. Set basic audit info
        auditEvent.setType(getAuditEventType(requestDetails));
        auditEvent.setAction(getAuditAction(requestDetails));
        auditEvent.setRecorded(new Date());
        auditEvent.setOutcome(AuditEvent.AuditEventOutcome._0); // Success (will update on response)
        
        // 2. Set source (the FHIR server)
        AuditEvent.AuditEventSourceComponent source = new AuditEvent.AuditEventSourceComponent();
        source.setSite("FHIR Server");
        source.addType().setSystem("http://terminology.hl7.org/CodeSystem/security-source-type")
              .setCode("4").setDisplay("Application Server");
        auditEvent.setSource(source);
        
        // 3. Set agent (user/client)
        AuditEvent.AuditEventAgentComponent agent = new AuditEvent.AuditEventAgentComponent();
        agent.setWho(new Reference().setDisplay(getClientInfo(request)));
        agent.setRequestor(true);
        
        // Extract user info from JWT if available
        String userId = extractUserFromRequest(request);
        if (userId != null) {
            agent.setAltId(userId);
        }
        
        // Set network info
        if (request != null) {
            AuditEvent.AuditEventAgentNetworkComponent network = new AuditEvent.AuditEventAgentNetworkComponent();
            network.setAddress(getClientIpAddress(request));
            network.setType(AuditEvent.AuditEventAgentNetworkType._2); // IP Address
            agent.setNetwork(network);
        }
        
        auditEvent.addAgent(agent);
        
        // 4. Set entity (the FHIR resource being accessed)
        String resourceType = extractResourceType(requestDetails);
        String resourceId = extractResourceId(requestDetails);
        
        // Always create an entity to capture request details
        AuditEvent.AuditEventEntityComponent entity = new AuditEvent.AuditEventEntityComponent();
        
        if (resourceType != null) {
            if (resourceId != null) {
                entity.setWhat(new Reference(resourceType + "/" + resourceId));
            } else {
                entity.setWhat(new Reference().setDisplay(resourceType + " (collection)"));
            }
            
            entity.setType(new Coding()
                .setSystem("http://terminology.hl7.org/CodeSystem/audit-entity-type")
                .setCode("2")
                .setDisplay("System Object"));
                
            entity.setRole(new Coding()
                .setSystem("http://terminology.hl7.org/CodeSystem/object-role")
                .setCode("4")
                .setDisplay("Domain Resource"));
                
            entity.addDetail()
                .setType("Resource Type")
                .setValue(new StringType(resourceType));
                
            if (resourceId != null) {
                entity.addDetail()
                    .setType("Resource ID")
                    .setValue(new StringType(resourceId));
            }
        } else {
            // If no specific resource found, still create entity for URL tracking
            entity.setWhat(new Reference().setDisplay("Request"));
            entity.setType(new Coding()
                .setSystem("http://terminology.hl7.org/CodeSystem/audit-entity-type")
                .setCode("3")
                .setDisplay("Report"));
        }
        
        // Add URL attribute - this captures the full request URL
        String fullUrl = getFullRequestUrl(requestDetails, request);
        entity.addDetail()
            .setType("URL")
            .setValue(new StringType(fullUrl));
        
        // Add HTTP Method
        entity.addDetail()
            .setType("HTTP Method")
            .setValue(new StringType(requestDetails.getRequestType().name()));
        
        // Add Request Headers
        String requestHeaders = extractRequestHeaders(request);
        if (!requestHeaders.isEmpty()) {
            entity.addDetail()
                .setType("Request Headers")
                .setValue(new StringType(requestHeaders));
        }
        
        // Add Request Body (for POST/PUT/PATCH requests)
        String requestBody = extractRequestBody(request);
        if (requestBody != null && !requestBody.isEmpty()) {
            entity.addDetail()
                .setType("Request Body")
                .setValue(new StringType(requestBody));
        }
        
        // Add Content Type
        String contentType = request.getContentType();
        if (contentType != null) {
            entity.addDetail()
                .setType("Content Type")
                .setValue(new StringType(contentType));
        }
        
        // Add Query Parameters
        String queryParams = extractQueryParameters(request);
        if (!queryParams.isEmpty()) {
            entity.addDetail()
                .setType("Query Parameters")
                .setValue(new StringType(queryParams));
        }
        
        // Add Remote Host/Port
        entity.addDetail()
            .setType("Remote Host")
            .setValue(new StringType(request.getRemoteHost() + ":" + request.getRemotePort()));
        
        // Add Session ID (if available)
        if (request.getSession(false) != null) {
            entity.addDetail()
                .setType("Session ID")
                .setValue(new StringType(request.getSession().getId()));
        }
        
        // Add Protocol and Scheme
        entity.addDetail()
            .setType("Protocol")
            .setValue(new StringType(request.getProtocol()));
            
        entity.addDetail()
            .setType("Scheme")
            .setValue(new StringType(request.getScheme()));
        
        auditEvent.addEntity(entity);
        
        return auditEvent;
    }

    private String extractRequestHeaders(HttpServletRequest request) {
        if (request == null) {
            return "";
        }
        
        StringBuilder headers = new StringBuilder();
        Enumeration<String> headerNames = request.getHeaderNames();
        
        while (headerNames.hasMoreElements()) {
            String headerName = headerNames.nextElement();
            String headerValue = request.getHeader(headerName);
            
            // No filtering - include all headers as-is
            headers.append(headerName).append(": ").append(headerValue).append("\n");
        }
        
        return headers.toString().trim();
    }

    private String extractAuthorizationInfo(HttpServletRequest request) {
        if (request == null) {
            return null;
        }
        
        String authorization = request.getHeader("Authorization");
        // Return the full authorization header without masking
        return authorization;
    }

    private String extractRequestBody(HttpServletRequest request) {
        if (request == null) {
            return null;
        }
        
        // Only capture body for POST, PUT, PATCH requests
        String method = request.getMethod();
        if (!"POST".equals(method) && !"PUT".equals(method) && !"PATCH".equals(method)) {
            return null;
        }
        
        try {
            BufferedReader reader = request.getReader();
            StringBuilder body = new StringBuilder();
            String line;
            
            while ((line = reader.readLine()) != null) {
                body.append(line).append("\n");
            }
            
            String bodyContent = body.toString().trim();
            
            // No size limit - return full body content
            return bodyContent.isEmpty() ? null : bodyContent;
            
        } catch (IOException | IllegalStateException e) {
            // Reader might already be consumed, this is common in servlet filters
            logger.debug("Could not read request body: {}", e.getMessage());
            return "[Body could not be read - likely already consumed]";
        }
    }

    private String extractQueryParameters(HttpServletRequest request) {
        if (request == null || request.getQueryString() == null) {
            return "";
        }
        
        return request.getQueryString();
    }

    private Coding getAuditEventType(RequestDetails requestDetails) {
        // Add null check for requestType
        if (requestDetails.getRequestType() == null) {
            return new Coding()
                .setSystem("http://dicom.nema.org/resources/ontology/DCM")
                .setCode("110114")
                .setDisplay("User Authentication");
        }
        
        String method = requestDetails.getRequestType().name();
        
        return switch (method) {
            case "GET" -> new Coding()
                    .setSystem("http://dicom.nema.org/resources/ontology/DCM")
                    .setCode("110112")
                    .setDisplay("Query Request");
            case "POST" -> new Coding()
                    .setSystem("http://dicom.nema.org/resources/ontology/DCM")
                    .setCode("110110")
                    .setDisplay("Patient Record");
            case "PUT", "PATCH" -> new Coding()
                    .setSystem("http://dicom.nema.org/resources/ontology/DCM")
                    .setCode("110111")
                    .setDisplay("Patient Record");
            case "DELETE" -> new Coding()
                    .setSystem("http://dicom.nema.org/resources/ontology/DCM")
                    .setCode("110113")
                    .setDisplay("Security Alert");
            default -> new Coding()
                    .setSystem("http://dicom.nema.org/resources/ontology/DCM")
                    .setCode("110114")
                    .setDisplay("User Authentication");
        };
    }

    private AuditEvent.AuditEventAction getAuditAction(RequestDetails requestDetails) {
        if (requestDetails.getRequestType() == null) {
            return AuditEvent.AuditEventAction.E; // Execute as default
        }
        
        String method = requestDetails.getRequestType().name();
        
        return switch (method) {
            case "GET" -> AuditEvent.AuditEventAction.R; // Read
            case "POST" -> AuditEvent.AuditEventAction.C; // Create
            case "PUT", "PATCH" -> AuditEvent.AuditEventAction.U; // Update
            case "DELETE" -> AuditEvent.AuditEventAction.D; // Delete
            default -> AuditEvent.AuditEventAction.E; // Execute
        };
    }

    private String extractResourceType(RequestDetails requestDetails) {
        if (requestDetails == null || requestDetails.getRequestPath() == null) {
            return null;
        }
        
        String requestPath = requestDetails.getRequestPath();
        if (requestPath.contains("/")) {
            String[] pathParts = requestPath.split("/");
            for (int i = 0; i < pathParts.length; i++) {
                if ("fhir".equals(pathParts[i]) && i + 1 < pathParts.length) {
                    String resourceType = pathParts[i + 1];
                    if (isValidFhirResourceType(resourceType)) {
                        return resourceType;
                    }
                }
            }
        }
        return null;
    }

    private String extractResourceId(RequestDetails requestDetails) {
        if (requestDetails == null || requestDetails.getRequestPath() == null) {
            return null;
        }
        
        String requestPath = requestDetails.getRequestPath();
        if (requestPath.contains("/")) {
            String[] pathParts = requestPath.split("/");
            for (int i = 0; i < pathParts.length; i++) {
                if ("fhir".equals(pathParts[i]) && i + 2 < pathParts.length) {
                    return pathParts[i + 2];
                }
            }
        }
        return null;
    }

    private boolean isValidFhirResourceType(String resourceType) {
        try {
            fhirContext.getResourceDefinition(resourceType);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    private String getClientInfo(HttpServletRequest request) {
        if (request == null) {
            return "Unknown Client";
        }
        
        String userAgent = request.getHeader("User-Agent");
        String clientIp = getClientIpAddress(request);
        return String.format("Client IP: %s, User-Agent: %s", clientIp, userAgent);
    }

    private String getClientIpAddress(HttpServletRequest request) {
        if (request == null) {
            return "Unknown";
        }
        
        String xForwardedFor = request.getHeader("X-Forwarded-For");
        if (xForwardedFor != null && !xForwardedFor.isEmpty()) {
            return xForwardedFor.split(",")[0].trim();
        }
        
        String xRealIp = request.getHeader("X-Real-IP");
        if (xRealIp != null && !xRealIp.isEmpty()) {
            return xRealIp;
        }
        
        return request.getRemoteAddr();
    }

    private String extractUserFromRequest(HttpServletRequest request) {
        if (request == null) {
            return null;
        }
        
        String authorization = request.getHeader("Authorization");
        if (authorization != null && authorization.startsWith("Bearer ")) {
            // TODO: Parse JWT token to extract user ID
            return "extracted-user-id";
        }
        return null;
    }

    // New method to construct the full request URL
    private String getFullRequestUrl(RequestDetails requestDetails, HttpServletRequest request) {
        if (request == null) {
            return requestDetails.getRequestPath();
        }
        
        StringBuilder url = new StringBuilder();
        
        // Build the base URL
        String scheme = request.getScheme();
        String serverName = request.getServerName();
        int serverPort = request.getServerPort();
        
        url.append(scheme).append("://").append(serverName);
        
        // Add port if it's not the default port
        if ((scheme.equals("http") && serverPort != 80) || 
            (scheme.equals("https") && serverPort != 443)) {
            url.append(":").append(serverPort);
        }
        
        // Add the request path
        String requestPath = requestDetails.getRequestPath();
        if (!requestPath.startsWith("/")) {
            url.append("/");
        }
        url.append(requestPath);
        
        // Add query string if present
        String queryString = request.getQueryString();
        if (queryString != null && !queryString.isEmpty()) {
            url.append("?").append(queryString);
        }
        
        return url.toString();
    }
}