package ca.uhn.fhir.jpa.starter.extra.service;

import java.util.Arrays;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.context.RuntimeResourceDefinition;


@Service
public class ScopeAuthorizationService {
    
    private static final Logger logger = LoggerFactory.getLogger(ScopeAuthorizationService.class);
    
    @Autowired
    private FhirContext fhirContext;
    
    // Regex patterns for different scope formats
    private static final Pattern SCOPE_PATTERN = Pattern.compile("(user|patient|system)/([^.]+)\\.(.+)");
    
    
    public boolean isAuthorizedForResource(String scopes, String fullUrlPath, String httpMethod, String patientId) {
        try {
            if (scopes == null || scopes.trim().isEmpty()) {
                return false;
            }

            logger.info("About to call isAuthorizedForFullBundlePush with params: '{}' '{}' '{}'", scopes, fullUrlPath, httpMethod);
            // Check if user is pushing full bundle as a system
            boolean resultFullBundlePush = isAuthorizedForFullBundlePush(scopes, fullUrlPath, httpMethod);
            if (resultFullBundlePush) {
                return true;
            }
            logger.info("isAuthorizedForFullBundlePush returned: {}", isAuthorizedForFullBundlePush(scopes, fullUrlPath, httpMethod));
            
            String resourceType = extractResourceTypeFromPath(fullUrlPath);
            if (resourceType == null) {
                logger.warn("No resource found in request {}", fullUrlPath);
                return false;
            }

            if (resourceType.equals("$export")) {
                logger.info("Querying for $export data, currently we authorized for all users to query this");
                return true;
            }
            
            String requiredOperation = mapHttpMethodToFhirOperation(httpMethod, fullUrlPath);
            if (requiredOperation == null) {
                logger.warn("No operation mapped for HTTP method: {}", httpMethod);
                return false;
            }

            boolean result = scopeGrantsAccess(scopes, resourceType, requiredOperation);
            return result;
        } catch (Exception e) {
            logger.error("Scope authorization failed: {}", e.getMessage(), e);
            return false;
        }
    }
    
    private String extractResourceTypeFromPath(String fullUrlPath) {
        if (fullUrlPath == null) {
            return null;
        }
        
        // Remove leading slash and query parameters
        String path = fullUrlPath.startsWith("/") ? fullUrlPath.substring(1) : fullUrlPath;
        // Remove params
        if (path.contains("?")) {
            path = path.substring(0, path.indexOf("?"));
        }
        
        String[] pathParts = path.split("/");
        
        // Check in reverse order, first valid resource is the target resource
        // For example: /fhir/Patient/1/Observation
        for (int i = pathParts.length - 1; i >= 0; i--) {
            if (pathParts[i].startsWith("$export")) {
                return "$export";
            }
            if (isValidFhirResourceType(pathParts[i])) {
                return pathParts[i];
            }
        }
        
        return null;
    }
    
    private boolean isValidFhirResourceType(String resourceType) {
        if (resourceType == null || resourceType.trim().isEmpty()) {
            return false;
        }
        
        try {
            // Use HAPI FHIR context to validate resource type
            RuntimeResourceDefinition resourceDef = fhirContext.getResourceDefinition(resourceType);
            return resourceDef != null;
        } catch (Exception e) {
            // If HAPI doesn't recognize it, it's not a valid FHIR resource
            logger.debug("Resource type '{}' not recognized by FHIR context", resourceType);
            return false;
        }
    }


    private String mapHttpMethodToFhirOperation(String httpMethod, String fullUrlPath) {
        if (httpMethod == null) {
            return null;
        }

        String method = httpMethod.toUpperCase();
        if ("POST".equals(method) && fullUrlPath != null && fullUrlPath.endsWith("/_search")) {
            return "read"; // FHIR search via POST
        }
        
        return switch (httpMethod.toUpperCase()) {
            case "GET" -> "read";
            case "POST" -> "create";
            case "PUT", "PATCH" -> "update";  // Multiple cases
            default -> {
                logger.warn("Unmapped HTTP method: {}", httpMethod);
                yield null;  // Use 'yield' for complex expressions
            }
        };
    }

    private boolean scopeGrantsAccess(String scopeString, String resourceType, String operation) {
        List<String> scopes = Arrays.stream(scopeString.trim().split("\\s+"))
                .filter(s -> !s.trim().isEmpty())
                .collect(Collectors.toList());
                
        for (String scope : scopes) {
            Matcher matcher = SCOPE_PATTERN.matcher(scope.trim());
            
            if (matcher.matches()) {
                String context = matcher.group(1);     // user, patient, system
                String resource = matcher.group(2);    // Patient, Observation, etc.
                String permission = matcher.group(3);  // rs, read, write, etc.
                
                if (resource.equals("*") || resource.equalsIgnoreCase(resourceType)) {
                    if (permissionAllowsOperation(permission, operation)) {
                        logger.debug("Access granted by scope: {}/{}.{} for {}/{}", 
                            context, resource, permission, resourceType, operation);
                        return true;
                    }
                }
            }
        }
        
        logger.debug("No scope in '{}' grants access to {}/{}", scopeString, resourceType, operation);
        return false;
    }

    private boolean permissionAllowsOperation(String permissions, String operation) {
        if (permissions == null || operation == null) {
            return false;
        }
        
        switch (permissions.toLowerCase()) {
            case "*":
                return true;
            case "rs":
            case "read":
                return "read".equals(operation);
            case "ws":
            case "write":
                return "create".equals(operation) || "update".equals(operation);
            case "ds":
            case "delete":
                return "delete".equals(operation);
            case "cruds":
            case "crud":
                return true;
            case "cru":
                return !"delete".equals(operation);
            case "ru":
                return "read".equals(operation) || "update".equals(operation);
            case "cr":
                return "create".equals(operation) || "read".equals(operation);
            default:
                return permissions.contains("r") && "read".equals(operation) ||
                       permissions.contains("w") && ("create".equals(operation) || "update".equals(operation)) ||
                       permissions.contains("c") && "create".equals(operation) ||
                       permissions.contains("u") && "update".equals(operation) ||
                       permissions.contains("d") && "delete".equals(operation);
        }
    }

    public boolean isAuthorizedForFullBundlePush(String scopes, String fullUrlPath, String httpMethod) {
        logger.info("Checking if authorized for full bundle push");
        try {
            // Check if HTTP method is POST
            if (!"POST".equalsIgnoreCase(httpMethod)) {
                logger.info("Bundle push requires POST method, got: {}", httpMethod);
                return false;
            }
            
            // Check if scopes contain "system" context
            if (scopes == null || !scopes.contains("system/")) {
                logger.info("Bundle push requires 'system' scope, got: {}", scopes);
                return false;
            }

            
            // Remove leading slash and query parameters
            String path = fullUrlPath.startsWith("/") ? fullUrlPath.substring(1) : fullUrlPath;
            if (path.contains("?")) {
                path = path.substring(0, path.indexOf("?"));
            }
            logger.info("Path after removing query parameters: {}", path);
            
            // Check for valid bundle push endpoints
            boolean isValidBundleEndpoint = fullUrlPath.isEmpty() ||           // POST to root: ""
                                        fullUrlPath.endsWith("/fhir/") ||       // POST to base: "fhir"
                                        fullUrlPath.endsWith("/$transaction") || // Explicit transaction
                                        fullUrlPath.endsWith("/$batch");       // Explicit batch
            
            if (isValidBundleEndpoint) {
                logger.info("Authorized for full bundle push - Scope: {}, Method: {}, Path: {}", 
                        scopes, httpMethod, fullUrlPath);
                return true;
            }
            
            logger.info("Not a valid bundle push endpoint: {}", fullUrlPath);
            return false;
            
        } catch (Exception e) {
            logger.error("Error checking bundle push authorization: {}", e.getMessage(), e);
            return false;
        }
    }

    public void logScopeAnalysis(List<String> scopes, String fullUrlPath, String httpMethod) {
        logger.info("=== Scope Authorization Analysis ===");
        logger.info("Request: {} {}", httpMethod, fullUrlPath);
        logger.info("Available scopes: {}", scopes);
        
        String resourceType = extractResourceTypeFromPath(fullUrlPath);
        String operation = mapHttpMethodToFhirOperation(httpMethod, fullUrlPath);
        
        logger.info("Extracted resource type: {}", resourceType);
        logger.info("Required operation: {}", operation);
        
        for (String scope : scopes) {
            boolean grants = scopeGrantsAccess(scope, resourceType, operation);
            logger.info("Scope '{}' grants access: {}", scope, grants);
        }
        logger.info("=== End Analysis ===");
    }
}