package ca.uhn.fhir.jpa.starter.extra.service;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import ca.uhn.fhir.jpa.starter.extra.service.types.ClientType;
import ca.uhn.fhir.jpa.starter.extra.service.types.TokenValidationResult;

@Service
public class TokenValidationService {
    
    private static final Logger logger = LoggerFactory.getLogger(TokenValidationService.class);
    
    @Value("${IDENTITY_SERVER_URL:http://192.168.56.1:8080/realms/fhir-realm}")
    private String identityServerUrl;

    @Value("${INTROSPECTION_CLIENT_ID:validation-service}")
    private String introspectionClientId;

    @Value("${INTROSPECTION_CLIENT_SECRET:njCJu4HFSaB15rHCM5OY0llsO3OuHvNv}")
    private String introspectionClientSecret;
    
    private final RestTemplate restTemplate;
    
    public TokenValidationService() {
        this.restTemplate = new RestTemplate();
    }
    
    public TokenValidationResult validateToken(String token) {
        try {
            String introspectionUrl = identityServerUrl + "/protocol/openid-connect/token/introspect";

            // Create request headers
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

            headers.add("Host", "192.168.56.1:8080");
            
            MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
            body.add("token", URLEncoder.encode(token, StandardCharsets.UTF_8));
            body.add("client_id", URLEncoder.encode(introspectionClientId, StandardCharsets.UTF_8));
            body.add("client_secret", URLEncoder.encode(introspectionClientSecret, StandardCharsets.UTF_8));

            HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<>(body, headers);
            
            // Log request details
            logger.debug("Sending token validation request to: {}", introspectionUrl);
            logger.debug("Request Content-Type: {}", headers.getContentType());
            logger.debug("Request Headers: {}", headers);
            logger.debug("Form data keys: {}", body.keySet());
            logger.debug("Token length: {} characters", token.length());
            logger.debug("Client ID: {}", introspectionClientId);
            
            // Make the request
            ResponseEntity<Map> response = restTemplate.postForEntity(
                introspectionUrl,
                requestEntity,
                Map.class
            );

            // Log response details
            logger.debug("Response status: {}", response.getStatusCode());
            logger.debug("Response headers: {}", response.getHeaders());
            
            // Check if response is successful and token is active
            if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
                Map<String, Object> responseBody = response.getBody();
                logger.debug("Full response body: {}", responseBody);
                Boolean active = (Boolean) responseBody.get("active");
                logger.info("Token's Active: {}", active);

                if (!active) {
                    return TokenValidationResult.builder()
                        .valid(false)
                        .type(ClientType.UNAUTHORIZED)
                        .failedMessage("Token isn't active")
                        .build();
                }

                ClientType clientType = getClientTypeFromString((String) responseBody.get("client_type"));
                // clientType.PUBLIC -> Access from patient/user, can only view resource with patient_id = fhirUser on their account
                switch (clientType) {
                    case PUBLIC:
                        // fhirUser = Patient/902
                        // -> patientId = 902
                        String fhirUser = (String) responseBody.get("fhirUser");
                        String patientId = fhirUser.split("/")[1];
                        return TokenValidationResult.builder()
                            .valid(true)
                            .type(clientType)
                            .username((String) responseBody.get("name"))
                            .scopes((String) responseBody.get("scope"))
                            .patientId(patientId)
                            .build();
                    case CREDENTIAL:
                        return TokenValidationResult.builder()
                            .valid(true)
                            .type(clientType)
                            .username((String) responseBody.get("name"))
                            .scopes((String) responseBody.get("scope"))
                            .build();
                }
            }

            return TokenValidationResult.builder()
                    .valid(false)
                    .type(ClientType.UNAUTHORIZED)
                    .failedMessage("Didn't receive any response from Introspect token server")
                    .build();
        } catch (HttpClientErrorException e) {
            logger.error("HTTP error during token validation - Status: {}, Response: {}", 
                        e.getStatusCode(), e.getResponseBodyAsString());
            
            if (e.getStatusCode() == HttpStatus.UNAUTHORIZED) {
                logger.warn("Token validation failed - Unauthorized");
            }
            
            return TokenValidationResult.builder()
                .valid(false)
                .type(ClientType.UNAUTHORIZED)
                .failedMessage("HTTP error during token validation")
                .build();
            
        } catch (Exception e) {
            logger.error("Unexpected error during token validation", e);
            return TokenValidationResult.builder()
                .valid(false)
                .type(ClientType.UNAUTHORIZED)
                .failedMessage("Unexpected error during token validation")
                .build();
        }
    }

    private ClientType getClientTypeFromString(String clientTypeString) {
        if (clientTypeString == null) {
            return ClientType.UNAUTHORIZED;
        }
        
        switch (clientTypeString.toLowerCase()) {
            case "credential":
                return ClientType.CREDENTIAL;
            case "public":
                return ClientType.PUBLIC;
            default:
                return ClientType.UNAUTHORIZED;
        }
    }
}