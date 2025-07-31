package ca.uhn.fhir.jpa.starter.extra.interceptor.auth;

import java.util.Arrays;
import java.util.Set;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import ca.uhn.fhir.interceptor.api.Hook;
import ca.uhn.fhir.interceptor.api.Interceptor;
import ca.uhn.fhir.interceptor.api.Pointcut;
import ca.uhn.fhir.jpa.starter.extra.service.ScopeAuthorizationService;
import ca.uhn.fhir.jpa.starter.extra.service.TokenValidationService;
import ca.uhn.fhir.jpa.starter.extra.service.types.ClientType;
import ca.uhn.fhir.jpa.starter.extra.service.types.TokenValidationResult;
import ca.uhn.fhir.rest.server.exceptions.AuthenticationException;
import ca.uhn.fhir.rest.server.exceptions.ForbiddenOperationException;
import ca.uhn.fhir.rest.server.servlet.ServletRequestDetails;
import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;

@Component
@Interceptor
public class AdminAuthorizationInterceptor {
    
    private static final Logger logger = LoggerFactory.getLogger(AdminAuthorizationInterceptor.class);
    
    @Autowired
    private TokenValidationService tokenValidationService;

    @Autowired
    private ScopeAuthorizationService scopeAuthorizationService;

    // Configure ignored paths
    @Value("${fhir.auth.ignored-paths:metadata,fhir/metadata,.well-known,fhir/.well-known,health,actuator/health}")
    private String ignoredPathsConfig;
    
    private Set<String> ignoredPaths;

    
    @PostConstruct
    public void init() {
        logger.info("=============== ADMIN INTERCEPTOR LOADED ===============");

        ignoredPaths = Arrays.stream(ignoredPathsConfig.split(","))
                .map(String::trim)
                .map(String::toLowerCase)
                .collect(Collectors.toSet());
        
        logger.info("Configured ignored paths: {}", ignoredPaths);
    }

    @Hook(Pointcut.SERVER_INCOMING_REQUEST_PRE_HANDLED)
    public void authorizeRequest(ServletRequestDetails requestDetails) {
        if (requestDetails == null) {
            throw new AuthenticationException("Request details not available");
        }

        if (shouldIgnorePath(requestDetails.getRequestPath())) {
            logger.debug("Ignoring authentication for path: {}", requestDetails.getRequestPath());
            return;
        }

        String requestPath = requestDetails.getRequestPath();
        String httpMethod = requestDetails.getRequestType().name();
        String authHeader = requestDetails.getHeader("Authorization");

        if (authHeader == null) {
            logger.warn("No Authorization header found for path: {}", requestDetails.getRequestPath());
            throw new AuthenticationException("Authorization header is required");
        }

        String token;
        if (authHeader.startsWith("Bearer ")) {
            token = authHeader.substring(7);
            logger.debug("Extracted form data: token={}", token);
        } else {
            token = authHeader;
        }


        TokenValidationResult validationResult = tokenValidationService.validateToken(token);

        if (!validationResult.isValid()) {
            logger.warn("Token validation failed for request: {} {}", 
                requestPath, httpMethod);
            throw new AuthenticationException(validationResult.getFailedMessage());
        }

        ClientType clientType = validationResult.getType();
        if (clientType == ClientType.UNAUTHORIZED) {
            logger.warn("Invalid token provided for request: {} {}", 
                requestDetails.getRequestType(), requestDetails.getRequestPath());
            throw new AuthenticationException("This token isn't authorized");
        }

        String scopes = validationResult.getScopes();
        String patientId = validationResult.getPatientId();
        Boolean isAuthorized = scopeAuthorizationService.isAuthorizedForResource(
            scopes,
            getFullUrl(requestDetails),
            httpMethod,
            patientId
        );

        if (!isAuthorized) {
            logger.warn("Access denied - no scope allowed operation");
            throw new ForbiddenOperationException("No scope permission allow for this resource");
        }

        String requestType = requestDetails.getRequestType().name();
        logger.info("Authorization successful - Scopes: {}, Operation: {}, Path: {}", 
            scopes, requestType);

        requestDetails.setAttribute("client_type", clientType);
        requestDetails.setAttribute("patient_id", patientId);
    }

    private boolean shouldIgnorePath(String requestPath) {
        if (requestPath == null) {
            return false;
        }

        String normalizedPath = requestPath.toLowerCase().trim();
        if (normalizedPath.startsWith("/")) {
            normalizedPath = normalizedPath.substring(1);
        }
        if (normalizedPath.endsWith("/")) {
            normalizedPath = normalizedPath.substring(0, normalizedPath.length() - 1);
        }

        if (ignoredPaths.contains(normalizedPath)) {
            return true;
        }
        return false;
    }

    private String getFullUrl(ServletRequestDetails requestDetails) {
        HttpServletRequest httpRequest = requestDetails.getServletRequest();

        // 1. Get the URL without the query string
        StringBuffer requestURL = httpRequest.getRequestURL();

        // 2. Get the query string (e.g., "?param1=value1&param2=value2")
        String queryString = httpRequest.getQueryString();

        // 3. Combine them to get the full URL
        String fullUrl = requestURL.toString();
        if (queryString != null && !queryString.isEmpty()) {
            fullUrl += "?" + queryString;
        }
        return fullUrl;
    }
}