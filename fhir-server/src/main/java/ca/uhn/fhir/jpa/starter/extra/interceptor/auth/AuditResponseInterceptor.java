package ca.uhn.fhir.jpa.starter.extra.interceptor.auth;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.interceptor.api.Hook;
import ca.uhn.fhir.interceptor.api.Interceptor;
import ca.uhn.fhir.interceptor.api.Pointcut;
import ca.uhn.fhir.jpa.api.dao.DaoRegistry;
import ca.uhn.fhir.jpa.api.dao.IFhirResourceDao;
import ca.uhn.fhir.rest.api.server.RequestDetails;
import ca.uhn.fhir.rest.api.server.ResponseDetails;
import ca.uhn.fhir.rest.server.servlet.ServletRequestDetails;
import org.hl7.fhir.instance.model.api.IBaseResource;
import org.hl7.fhir.r4.model.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.core.annotation.Order;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.concurrent.ConcurrentHashMap;
import ca.uhn.fhir.rest.server.exceptions.BaseServerResponseException;
import ca.uhn.fhir.rest.server.exceptions.ForbiddenOperationException;
import ca.uhn.fhir.jpa.starter.extra.service.types.ClientType;
import ca.uhn.fhir.jpa.starter.extra.service.util.JwtUtil;
import java.util.Map;

@Component
@Interceptor
@Order(200)
public class AuditResponseInterceptor {

    private static final Logger logger = LoggerFactory.getLogger(AuditResponseInterceptor.class);

    @Value("${AUDIT_SERVER_ENDPOINT:http://localhost:5000/audit-event}")
    private String AUDIT_ENDPOINT;

    @Autowired
    private FhirContext fhirContext;
    
    @Autowired
    private DaoRegistry daoRegistry;
    
    private final RestTemplate restTemplate = new RestTemplate();
    
    // Store captured response bodies temporarily
    private final ConcurrentHashMap<String, String> capturedResponses = new ConcurrentHashMap<>();
    
    // Track access status for each request
    private final ConcurrentHashMap<String, Boolean> accessGranted = new ConcurrentHashMap<>();

    // Track which requests have already sent audit events
    private final ConcurrentHashMap<String, Boolean> auditEventSent = new ConcurrentHashMap<>();

    // COMBINE BOTH HOOKS INTO ONE - Capture response resource before AfterAccessInterceptor processes it
    @Hook(Pointcut.SERVER_OUTGOING_RESPONSE)
    public void captureResponseResource(RequestDetails theRequestDetails, IBaseResource theResource,
                                      HttpServletRequest theServletRequest, HttpServletResponse theServletResponse) {
        if (theRequestDetails != null && theResource != null) {
            try {
                String requestId = getRequestId(theRequestDetails);
                String resourceJson = fhirContext.newJsonParser()
                    .setPrettyPrint(true)
                    .encodeResourceToString(theResource);
                
                capturedResponses.put(requestId, resourceJson);
                
                // IMPORTANT: Mark as initially granted (will be changed to false if AfterAccessInterceptor throws exception)
                accessGranted.put(requestId, true);
                
                logger.debug("Captured response resource for request {}: {}", requestId, theResource.getClass().getSimpleName());
                
            } catch (Exception e) {
                logger.debug("Failed to capture response resource: {}", e.getMessage());
            }
        }
    }

    // Handle exceptions from AfterAccessInterceptor
    @Hook(Pointcut.SERVER_HANDLE_EXCEPTION)
    public void auditFailedAccess(RequestDetails theRequestDetails, BaseServerResponseException theException,
                                 HttpServletRequest theServletRequest, HttpServletResponse theServletResponse) {
        
        // Only handle ForbiddenOperationException from AfterAccessInterceptor
        if (theException instanceof ForbiddenOperationException) {
            String requestId = getRequestId(theRequestDetails);
            
            // CHECK: If audit event already sent for this request, return early
            if (auditEventSent.putIfAbsent(requestId, true) != null) {
                logger.debug("Audit event already sent for request {}, skipping duplicate", requestId);
                return;
            }
            
            // IMPORTANT: Mark access as denied
            accessGranted.put(requestId, false);
            
            logger.info("Access denied by AfterAccessInterceptor for request {}: {}", requestId, theException.getMessage());
            
            try {
                AuditEvent failedAccessAudit = createFailedAccessAuditEvent(theRequestDetails, theException, theServletRequest, theServletResponse);
                
                if (failedAccessAudit != null) {
                    // Save the failed access audit event
                    IFhirResourceDao<AuditEvent> auditEventDao = daoRegistry.getResourceDao(AuditEvent.class);
                    auditEventDao.create(failedAccessAudit, theRequestDetails);
                    logger.info("Failed access audit event created for request: {}", theRequestDetails.getRequestPath());
                }
                
                // Clean up captured response immediately for failed access
                capturedResponses.remove(requestId);
            } catch (Exception e) {
                logger.error("Failed to create failed access audit event: {}", e.getMessage(), e);
            }
        }
    }

    // Main audit method - only audit successful responses
    @Hook(Pointcut.SERVER_PROCESSING_COMPLETED)
    public void auditResponse(RequestDetails theRequestDetails, ResponseDetails theResponseDetails, 
                             HttpServletRequest theServletRequest, HttpServletResponse theServletResponse) {
        
        if (theRequestDetails == null) {
            logger.warn("RequestDetails is null, skipping response audit event creation");
            return;
        }
        
        String requestId = getRequestId(theRequestDetails);
        
        // CHECK: If audit event already sent for this request, return early
        if (auditEventSent.putIfAbsent(requestId, true) != null) {
            logger.debug("Audit event already sent for request {}, skipping duplicate", requestId);
            // Clean up and return
            capturedResponses.remove(requestId);
            accessGranted.remove(requestId);
            return;
        }
        
        // Check if access was denied by AfterAccessInterceptor
        Boolean wasAccessGranted = accessGranted.get(requestId);
        
        logger.debug("Checking access status for request {}: {}", requestId, wasAccessGranted);
        
        if (wasAccessGranted != null && !wasAccessGranted) {
            logger.info("Skipping successful response audit for request {} - access was denied by AfterAccessInterceptor", requestId);
            // Clean up and exit - don't create success audit
            accessGranted.remove(requestId);
            auditEventSent.remove(requestId); // Remove the flag since we're not sending an audit
            return;
        }
        
        // Only create success audit if access was granted or not checked yet
        if (wasAccessGranted == null || wasAccessGranted) {
            try {
                AuditEvent responseAuditEvent = createResponseAuditEvent(theRequestDetails, theResponseDetails, theServletRequest, theServletResponse);
                
                if (responseAuditEvent != null) {
                    // Add access validation information
                    addAccessValidationInfo(responseAuditEvent, theRequestDetails, true);
                    
                    // Save the response AuditEvent to FHIR database
                    IFhirResourceDao<AuditEvent> auditEventDao = daoRegistry.getResourceDao(AuditEvent.class);
                    auditEventDao.create(responseAuditEvent, theRequestDetails);
                    logger.info("Response audit event created successfully for request: {}", theRequestDetails.getRequestPath());
                }
                
            } catch (Exception e) {
                logger.error("Failed to create response audit event for request: {} - Error: {}", 
                            theRequestDetails.getRequestPath(), e.getMessage(), e);
            }
        }
        
        // Clean up captured response
        capturedResponses.remove(requestId);
        accessGranted.remove(requestId);
        // Don't remove auditEventSent flag here - it stays to prevent duplicates
    }

    // ADD THIS: Cleanup method to prevent memory leaks
    @Hook(Pointcut.SERVER_PROCESSING_COMPLETED_NORMALLY)
    public void cleanupAfterRequest(RequestDetails theRequestDetails) {
        if (theRequestDetails != null) {
            String requestId = getRequestId(theRequestDetails);
            
            // Clean up all tracking data after request is completely processed
            capturedResponses.remove(requestId);
            accessGranted.remove(requestId);
            auditEventSent.remove(requestId);
            
            logger.debug("Cleaned up all tracking data for request: {}", requestId);
        }
    }

    // CREATE AUDIT EVENT FOR FAILED ACCESS (KEEP ONLY ONE VERSION)
    private AuditEvent createFailedAccessAuditEvent(RequestDetails requestDetails, BaseServerResponseException exception,
                                                   HttpServletRequest servletRequest, HttpServletResponse servletResponse) {
        
        AuditEvent auditEvent = new AuditEvent();
        
        // Set as security alert for failed access
        auditEvent.setType(new Coding()
            .setSystem("http://dicom.nema.org/resources/ontology/DCM")
            .setCode("110113")
            .setDisplay("Security Alert"));
            
        auditEvent.setAction(getAuditAction(requestDetails));
        auditEvent.setRecorded(new Date());
        auditEvent.setOutcome(AuditEvent.AuditEventOutcome._4); // Minor failure
        
        // Set source
        AuditEvent.AuditEventSourceComponent source = new AuditEvent.AuditEventSourceComponent();
        source.setSite("FHIR Server Access Control");
        source.addType().setSystem("http://terminology.hl7.org/CodeSystem/security-source-type")
              .setCode("4").setDisplay("Application Server");
        auditEvent.setSource(source);
        
        // Set agent
        AuditEvent.AuditEventAgentComponent agent = new AuditEvent.AuditEventAgentComponent();
        agent.setWho(new Reference().setDisplay(getClientInfo(servletRequest)));
        agent.setRequestor(true);
        
        // Extract user info from JWT if available
        String userId = extractUserFromRequest(servletRequest);
        if (userId != null) {
            agent.setAltId(userId);
        }
        
        if (servletRequest != null) {
            AuditEvent.AuditEventAgentNetworkComponent network = new AuditEvent.AuditEventAgentNetworkComponent();
            network.setAddress(getClientIpAddress(servletRequest));
            network.setType(AuditEvent.AuditEventAgentNetworkType._2);
            agent.setNetwork(network);
        }
        
        auditEvent.addAgent(agent);
        
        // Set entity with failure details
        AuditEvent.AuditEventEntityComponent entity = new AuditEvent.AuditEventEntityComponent();
        entity.setWhat(new Reference().setDisplay("Failed Access Attempt"));
        entity.setType(new Coding()
            .setSystem("http://terminology.hl7.org/CodeSystem/audit-entity-type")
            .setCode("3")
            .setDisplay("Report"));
        
        // Add failure details
        entity.addDetail()
            .setType("Request URL")
            .setValue(new StringType(getFullRequestUrl(requestDetails, servletRequest)));
            
        entity.addDetail()
            .setType("Request Method")
            .setValue(new StringType(requestDetails.getRequestType().name()));
            
        entity.addDetail()
            .setType("Failure Reason")
            .setValue(new StringType(exception.getMessage()));
            
        entity.addDetail()
            .setType("HTTP Status Code")
            .setValue(new StringType(String.valueOf(exception.getStatusCode())));
            
        entity.addDetail()
            .setType("Exception Type")
            .setValue(new StringType(exception.getClass().getSimpleName()));

        // Add the captured response body (what would have been returned)
        String requestId = getRequestId(requestDetails);
        String capturedResponse = capturedResponses.get(requestId);
        if (capturedResponse != null) {
            entity.addDetail()
                .setType("Would-be Response Body")
                .setValue(new StringType(capturedResponse));
        }
            
        entity.addDetail()
            .setType("Failure Timestamp")
            .setValue(new StringType(new Date().toString()));
        
        auditEvent.addEntity(entity);
        
        // Add access validation info AFTER creating the entity to prevent duplicates
        addAccessValidationInfo(auditEvent, requestDetails, false);
        
        return auditEvent;
    }

    // ADD ACCESS VALIDATION INFO (KEEP ONLY ONE VERSION)
    private void addAccessValidationInfo(AuditEvent auditEvent, RequestDetails requestDetails, boolean accessGranted) {
        if (requestDetails instanceof ServletRequestDetails) {
            ServletRequestDetails servletDetails = (ServletRequestDetails) requestDetails;
            
            // Get client type and patient ID from AfterAccessInterceptor
            ClientType clientType = (ClientType) servletDetails.getAttribute("client_type");
            String patientId = (String) servletDetails.getAttribute("patient_id");
            
            // Find the entity to add validation info
            if (!auditEvent.getEntity().isEmpty()) {
                AuditEvent.AuditEventEntityComponent entity = auditEvent.getEntity().get(0);
                
                // Add client type
                if (clientType != null) {
                    entity.addDetail()
                        .setType("Client Type")
                        .setValue(new StringType(clientType.toString()));
                }
                
                // Add patient ID from token
                if (patientId != null) {
                    entity.addDetail()
                        .setType("Patient ID (from token)")
                        .setValue(new StringType(patientId));
                }
                
                // ONLY ADD "Access Validation" if it doesn't already exist
                boolean hasAccessValidation = entity.getDetail().stream()
                    .anyMatch(detail -> "Access Validation".equals(detail.getType()));
                
                if (!hasAccessValidation) {
                    entity.addDetail()
                        .setType("Access Validation")
                        .setValue(new StringType(accessGranted ? "PASSED" : "FAILED"));
                }
                    
                // Add validation timestamp
                entity.addDetail()
                    .setType("Validation Timestamp")
                    .setValue(new StringType(new Date().toString()));
            }
        }
    }

    // GET REQUEST ID (KEEP ONLY ONE VERSION)
    private String getRequestId(RequestDetails requestDetails) {
        // Create a more consistent ID for the same request across different pointcuts
        String basePath = requestDetails.getRequestPath();
        long threadId = Thread.currentThread().getId();
        
        if (requestDetails instanceof ServletRequestDetails) {
            ServletRequestDetails servletDetails = (ServletRequestDetails) requestDetails;
            HttpServletRequest servletRequest = servletDetails.getServletRequest();
            if (servletRequest != null) {
                // Use request hashCode for consistency within the same request processing
                return basePath + "_" + threadId + "_" + servletRequest.hashCode();
            }
        }
        return basePath + "_" + threadId;
    }

    private AuditEvent createResponseAuditEvent(RequestDetails requestDetails, ResponseDetails responseDetails,
                                               HttpServletRequest servletRequest, HttpServletResponse servletResponse) {
        if (requestDetails == null || requestDetails.getRequestType() == null) {
            logger.warn("RequestDetails or RequestType is null in createResponseAuditEvent");
            return null;
        }
        String time = new Date().toString();
        String authHeader = servletRequest != null ? servletRequest.getHeader("Authorization") : null;
        Map<String, Object> claims = JwtUtil.parseJwt(authHeader);
        String userType = JwtUtil.getUserType(claims);
        String userId = JwtUtil.getUserId(claims);
        String scopes = JwtUtil.getScopes(claims);
        if (userType.equals("unknown")) userType = "unknown (token missing or invalid)";
        if (userId.equals("unknown")) userId = "unknown (token missing or invalid)";
        if (scopes.equals("no_scope")) scopes = "no_scope (token missing or invalid)";
        int responseCode = getResponseCode(responseDetails, servletResponse);
        String responseBody = extractResponseBodyEnhanced(requestDetails, responseDetails);
        String bodyType = "unknown";
        if (responseDetails != null && responseDetails.getResponseResource() != null) {
            bodyType = responseDetails.getResponseResource().getClass().getSimpleName();
        }
        int bodyLength = responseBody != null ? responseBody.length() : 0;
        // Structured log line (JSON-like)
        logger.info("AUDIT_RESPONSE | time={} | responseCode={} | bodyType={} | bodyLength={} | userType={} | userId={} | scopes={} | responseBody={}",
            time, responseCode, bodyType, bodyLength, userType, userId, scopes, responseBody);
        
        AuditEvent auditEvent = new AuditEvent();
        
        // 1. Set basic audit info for response
        auditEvent.setType(getResponseAuditEventType(requestDetails, responseDetails));
        auditEvent.setAction(getAuditAction(requestDetails));
        auditEvent.setRecorded(new Date());
        auditEvent.setOutcome(getOutcomeFromResponse(responseDetails, servletResponse));
        
        // 2. Set source (the FHIR server)
        AuditEvent.AuditEventSourceComponent source = new AuditEvent.AuditEventSourceComponent();
        source.setSite("FHIR Server Response");
        source.addType().setSystem("http://terminology.hl7.org/CodeSystem/security-source-type")
              .setCode("4").setDisplay("Application Server");
        auditEvent.setSource(source);
        
        // 3. Set agent (user/client)
        AuditEvent.AuditEventAgentComponent agent = new AuditEvent.AuditEventAgentComponent();
        agent.setWho(new Reference().setDisplay(getClientInfo(servletRequest)));
        agent.setRequestor(true);
        
        // Extract user info from JWT if available
        String userIdFromJwt = extractUserFromRequest(servletRequest);
        if (userIdFromJwt != null) {
            agent.setAltId(userIdFromJwt);
        }
        
        // Set network info
        if (servletRequest != null) {
            AuditEvent.AuditEventAgentNetworkComponent network = new AuditEvent.AuditEventAgentNetworkComponent();
            network.setAddress(getClientIpAddress(servletRequest));
            network.setType(AuditEvent.AuditEventAgentNetworkType._2); // IP Address
            agent.setNetwork(network);
        }
        
        auditEvent.addAgent(agent);
        
        // 4. Set entity (the FHIR resource response details)
        String resourceType = extractResourceType(requestDetails);
        String resourceId = extractResourceId(requestDetails);
        
        AuditEvent.AuditEventEntityComponent entity = new AuditEvent.AuditEventEntityComponent();
        
        if (resourceType != null) {
            if (resourceId != null) {
                entity.setWhat(new Reference(resourceType + "/" + resourceId));
            } else {
                entity.setWhat(new Reference().setDisplay(resourceType + " (collection response)"));
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
            entity.setWhat(new Reference().setDisplay("Response"));
            entity.setType(new Coding()
                .setSystem("http://terminology.hl7.org/CodeSystem/audit-entity-type")
                .setCode("3")
                .setDisplay("Report"));
        }
        
        // Add Response-specific details
        
        // Response Status Code
        entity.addDetail()
            .setType("Response Status Code")
            .setValue(new StringType(String.valueOf(responseCode)));
        
        // Response Status Message
        String statusMessage = getStatusMessage(responseCode);
        entity.addDetail()
            .setType("Response Status Message")
            .setValue(new StringType(statusMessage));
        
        // Original Request URL
        String fullUrl = getFullRequestUrl(requestDetails, servletRequest);
        entity.addDetail()
            .setType("Request URL")
            .setValue(new StringType(fullUrl));
        
        // Request Method
        entity.addDetail()
            .setType("Request Method")
            .setValue(new StringType(requestDetails.getRequestType().name()));
        
        // Response Headers
        String responseHeaders = extractResponseHeaders(servletResponse);
        if (!responseHeaders.isEmpty()) {
            entity.addDetail()
                .setType("Response Headers")
                .setValue(new StringType(responseHeaders));
        }
        
        // Response Content Type
        if (servletResponse != null && servletResponse.getContentType() != null) {
            entity.addDetail()
                .setType("Response Content Type")
                .setValue(new StringType(servletResponse.getContentType()));
        }
        
        // Response Content Length
        if (servletResponse != null) {
            String contentLength = servletResponse.getHeader("Content-Length");
            entity.addDetail()
                .setType("Response Content Length")
                .setValue(new StringType(contentLength != null ? contentLength : "Unknown"));
        }
        
        // Response Body - Enhanced extraction
        entity.addDetail()
            .setType("Response Body")
            .setValue(new StringType(responseBody));
        
        // Processing time (if available from request attributes)
        Long processingTime = getProcessingTime(servletRequest);
        if (processingTime != null) {
            entity.addDetail()
                .setType("Processing Time (ms)")
                .setValue(new StringType(String.valueOf(processingTime)));
        }
        
        // Response Timestamp
        entity.addDetail()
            .setType("Response Timestamp")
            .setValue(new StringType(new Date().toString()));
        
        auditEvent.addEntity(entity);
        
        return auditEvent;
    }

    // Enhanced response body extraction using multiple methods
    private String extractResponseBodyEnhanced(RequestDetails requestDetails, ResponseDetails responseDetails) {
        StringBuilder result = new StringBuilder();
        String requestId = getRequestId(requestDetails);
        
        // Method 1: Check captured responses from SERVER_OUTGOING_RESPONSE
        String capturedResponse = capturedResponses.get(requestId);
        if (capturedResponse != null) {
            result.append("CAPTURED_RESPONSE: ").append(capturedResponse);
            return result.toString();
        }
        
        // Method 2: Try ResponseDetails
        if (responseDetails != null) {
            try {
                IBaseResource responseResource = responseDetails.getResponseResource();
                if (responseResource != null) {
                    String resourceJson = fhirContext.newJsonParser()
                        .setPrettyPrint(true)
                        .encodeResourceToString(responseResource);
                    result.append("RESPONSE_DETAILS: ").append(resourceJson);
                    return result.toString();
                }
            } catch (Exception e) {
                result.append("RESPONSE_DETAILS_ERROR: ").append(e.getMessage()).append("\n");
            }
        }
        
        // Method 3: Try RequestDetails attributes
        if (requestDetails instanceof ServletRequestDetails) {
            ServletRequestDetails servletDetails = (ServletRequestDetails) requestDetails;
            
            // Check various attribute names that might contain response data
            String[] attributeNames = {
                "responseResource", "response", "responseBody", "fhirResponse", 
                "processedResponse", "outputResource", "resultResource"
            };
            
            for (String attrName : attributeNames) {
                Object attr = servletDetails.getAttribute(attrName);
                if (attr != null) {
                    if (attr instanceof IBaseResource) {
                        try {
                            String resourceJson = fhirContext.newJsonParser()
                                .setPrettyPrint(true)
                                .encodeResourceToString((IBaseResource) attr);
                            result.append("ATTRIBUTE_").append(attrName.toUpperCase()).append(": ").append(resourceJson);
                            return result.toString();
                        } catch (Exception e) {
                            result.append("ATTRIBUTE_").append(attrName.toUpperCase()).append("_ERROR: ").append(e.getMessage()).append("\n");
                        }
                    } else {
                        result.append("ATTRIBUTE_").append(attrName.toUpperCase()).append(": ").append(attr.toString()).append("\n");
                    }
                }
            }
        }
        
        // Method 4: Debug info
        result.append("DEBUG_INFO:\n");
        result.append("RequestDetails: ").append(requestDetails != null ? requestDetails.getClass().getSimpleName() : "null").append("\n");
        result.append("ResponseDetails: ").append(responseDetails != null ? responseDetails.getClass().getSimpleName() : "null").append("\n");
        result.append("CapturedResponses size: ").append(capturedResponses.size()).append("\n");
        result.append("RequestId: ").append(requestId).append("\n");
        
        if (result.length() == 0) {
            return "[No response body could be captured using any method]";
        }
        
        return result.toString();
    }

    private int getResponseCode(ResponseDetails responseDetails, HttpServletResponse servletResponse) {
        // Try to get from ResponseDetails first
        if (responseDetails != null) {
            Integer responseCode = responseDetails.getResponseCode();
            if (responseCode != null) {
                return responseCode;
            }
        }
        
        // Fallback to servlet response
        if (servletResponse != null) {
            return servletResponse.getStatus();
        }
        
        return 200; // Default
    }

    private AuditEvent.AuditEventOutcome getOutcomeFromResponse(ResponseDetails responseDetails, HttpServletResponse servletResponse) {
        int status = getResponseCode(responseDetails, servletResponse);
        
        if (status >= 200 && status < 300) {
            return AuditEvent.AuditEventOutcome._0; // Success
        } else if (status >= 300 && status < 400) {
            return AuditEvent.AuditEventOutcome._0; // Success (redirects are still successful)
        } else if (status >= 400 && status < 500) {
            return AuditEvent.AuditEventOutcome._4; // Minor failure
        } else if (status >= 500) {
            return AuditEvent.AuditEventOutcome._8; // Major failure
        }
        
        return AuditEvent.AuditEventOutcome._12; // Unknown
    }

    private Coding getResponseAuditEventType(RequestDetails requestDetails, ResponseDetails responseDetails) {
        // Determine type based on response status
        int status = getResponseCode(responseDetails, null);
        
        if (status >= 400) {
            return new Coding()
                .setSystem("http://dicom.nema.org/resources/ontology/DCM")
                .setCode("110113")
                .setDisplay("Security Alert"); // Error responses
        }
        
        String method = requestDetails.getRequestType().name();
        return switch (method) {
            case "GET" -> new Coding()
                    .setSystem("http://dicom.nema.org/resources/ontology/DCM")
                    .setCode("110112")
                    .setDisplay("Query Response");
            case "POST" -> new Coding()
                    .setSystem("http://dicom.nema.org/resources/ontology/DCM")
                    .setCode("110110")
                    .setDisplay("Patient Record Response");
            case "PUT", "PATCH" -> new Coding()
                    .setSystem("http://dicom.nema.org/resources/ontology/DCM")
                    .setCode("110111")
                    .setDisplay("Patient Record Response");
            case "DELETE" -> new Coding()
                    .setSystem("http://dicom.nema.org/resources/ontology/DCM")
                    .setCode("110113")
                    .setDisplay("Security Alert Response");
            default -> new Coding()
                    .setSystem("http://dicom.nema.org/resources/ontology/DCM")
                    .setCode("110114")
                    .setDisplay("User Authentication Response");
        };
    }

    private String getStatusMessage(int statusCode) {
        return switch (statusCode) {
            case 200 -> "OK";
            case 201 -> "Created";
            case 204 -> "No Content";
            case 400 -> "Bad Request";
            case 401 -> "Unauthorized";
            case 403 -> "Forbidden";
            case 404 -> "Not Found";
            case 409 -> "Conflict";
            case 422 -> "Unprocessable Entity";
            case 500 -> "Internal Server Error";
            case 502 -> "Bad Gateway";
            case 503 -> "Service Unavailable";
            default -> "HTTP " + statusCode;
        };
    }

    private String extractResponseHeaders(HttpServletResponse response) {
        if (response == null) {
            return "";
        }
        
        StringBuilder headers = new StringBuilder();
        for (String headerName : response.getHeaderNames()) {
            String headerValue = response.getHeader(headerName);
            headers.append(headerName).append(": ").append(headerValue).append("\n");
        }
        
        return headers.toString().trim();
    }

    private Long getProcessingTime(HttpServletRequest request) {
        if (request == null) {
            return null;
        }
        
        Object startTime = request.getAttribute("requestStartTime");
        if (startTime instanceof Long) {
            return System.currentTimeMillis() - (Long) startTime;
        }
        return null;
    }

    private AuditEvent.AuditEventAction getAuditAction(RequestDetails requestDetails) {
        if (requestDetails.getRequestType() == null) {
            return AuditEvent.AuditEventAction.E;
        }
        
        String method = requestDetails.getRequestType().name();
        return switch (method) {
            case "GET" -> AuditEvent.AuditEventAction.R;
            case "POST" -> AuditEvent.AuditEventAction.C;
            case "PUT", "PATCH" -> AuditEvent.AuditEventAction.U;
            case "DELETE" -> AuditEvent.AuditEventAction.D;
            default -> AuditEvent.AuditEventAction.E;
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

    private String getFullRequestUrl(RequestDetails requestDetails, HttpServletRequest request) {
        if (request == null) {
            return requestDetails.getRequestPath();
        }
        
        StringBuilder url = new StringBuilder();
        
        String scheme = request.getScheme();
        String serverName = request.getServerName();
        int serverPort = request.getServerPort();
        
        url.append(scheme).append("://").append(serverName);
        
        if ((scheme.equals("http") && serverPort != 80) || 
            (scheme.equals("https") && serverPort != 443)) {
            url.append(":").append(serverPort);
        }
        
        String requestPath = requestDetails.getRequestPath();
        if (!requestPath.startsWith("/")) {
            url.append("/");
        }
        url.append(requestPath);
        
        String queryString = request.getQueryString();
        if (queryString != null && !queryString.isEmpty()) {
            url.append("?").append(queryString);
        }
        
        return url.toString();
    }
}