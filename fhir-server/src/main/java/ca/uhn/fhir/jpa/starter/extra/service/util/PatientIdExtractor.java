package ca.uhn.fhir.jpa.starter.extra.service.util;

import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Utility class for extracting patient IDs from FHIR request paths and query parameters
 */
public class PatientIdExtractor {
    
    private static final Logger logger = LoggerFactory.getLogger(PatientIdExtractor.class);
    
    /**
     * Extracts patient ID from various FHIR request paths and query parameters
     * 
     * @param requestPath The full request path including query parameters
     * @return The patient ID if found, null otherwise
     */
    public static String extractPatientIdFromPath(String URI) {
        if (URI == null || URI.trim().isEmpty()) {
            logger.info("Extracting patient ID but URI is empty. Path: {}", URI);
            return null;
        }
        
        logger.info("Extracting patient ID from URI: {}", URI);
        
        try {
            // Extract request path from URI
            // URI: https://fhir-server.gentlecliff-869c2758.centralus.azurecontainerapps.io/fhir/Encounter?patient=902
            // -> requestPath: /Encounter?patient=902
            String requestPath;
            int fhirIndex = URI.lastIndexOf("/fhir/");
            if (fhirIndex != -1) {
                requestPath = URI.substring(fhirIndex + 5); // +5 to skip "/fhir"
            } else {
                logger.warn("URI does not contain '/fhir/' path: {}", URI);
                return null;
            }
            // Split path and query parameters
            String[] pathAndQuery = requestPath.split("\\?", 2);
            String path = pathAndQuery[0];
            String queryString = pathAndQuery.length > 1 ? pathAndQuery[1] : null;
            
            // Method 1: Direct Patient resource access
            // /Patient/123 or /Patient?_id=123
            if (path.contains("/Patient")) {
                String patientId = extractDirectPatientId(path, queryString);
                if (patientId != null) {
                    logger.debug("Found patient ID from direct Patient path: {}", patientId);
                    return patientId;
                }
            }
            
            // Method 2: Request for other resource
            // -> We force them to have param patient=[id] to confirm it
            if (queryString != null && !queryString.isEmpty()) {
                String patientId = extractPatientIdFromQuery(queryString);
                if (patientId != null) {
                    logger.debug("Found patient ID from query parameters: {}", patientId);
                    return patientId;
                }
            }
            
            logger.info("No patient ID found in path: {}", requestPath);
            return null;
            
        } catch (Exception e) {
            logger.error("Error extracting patient ID from URI: {}", URI, e);
            return null;
        }
    }

    /**
     * Extracts patient ID from direct Patient resource paths
     * Examples: /Patient/123
     */
    private static String extractDirectPatientId(String path, String queryString) {
        // Case: /Patient/902
        if (path.startsWith("/Patient/")) {
            String[] parts = path.split("/");
            if (parts.length >= 3) {
                return parts[2];
            }
        }

        // Case: /Patient?_id=902 or /Patient?email=mail&_id=902
        String[] params = queryString.split("&");
        for (String param : params) {
            String[] keyValue = param.split("=", 2);
            if (keyValue.length == 2 && keyValue[0].equals("_id")) {
                return keyValue[1];
            }
        }

        logger.warn("Request for Patient resource but can't find patient id. Full requestPath and queryString: {} | {}", path, queryString);
        return null; // No patient ID found
    }

    /**
     * Extracts patient ID from query parameters
     * Handles: patient=123, subject=123, subject=Patient/123
     */
    private static String extractPatientIdFromQuery(String queryString) {
        if (queryString == null || queryString.isEmpty()) {
            return null;
        }
        
        try {
            // Split query parameters
            String[] params = queryString.split("&");
            
            for (String param : params) {
                String[] keyValue = param.split("=", 2);
                if (keyValue.length != 2) continue;
                
                String key = keyValue[0].trim();
                String value = keyValue[1].trim();
                
                // Decode URL encoding if present
                value = URLDecoder.decode(value, StandardCharsets.UTF_8);
                
                String patientId = null;
                
                switch (key.toLowerCase()) {
                    case "patient":
                        // patient=123
                        patientId = extractPatientIdFromValue(value);
                        break;
                        
                    case "subject":
                        // subject=123 or subject=Patient/123
                        patientId = extractPatientIdFromValue(value);
                        break;
                        
                    default:
                        // Could extend for other parameters like performer.reference, etc.
                        break;
                }
                
                if (patientId != null) {
                    logger.debug("Found patient ID '{}' from query parameter '{}={}'", patientId, key, value);
                    return patientId;
                }
            }
            
            return null;
            
        } catch (Exception e) {
            logger.error("Error extracting patient ID from query string: {}", queryString, e);
            return null;
        }
    }

    /**
     * Extracts patient ID from parameter values
     * Handles: "123", "Patient/123"
     */
    private static String extractPatientIdFromValue(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        
        value = value.trim();
        
        // Handle Patient/123 format
        if (value.startsWith("Patient/")) {
            String patientId = value.substring("Patient/".length());
            patientId = cleanPatientId(patientId);
            return isValidPatientId(patientId) ? patientId : null;
        }
        
        // Handle direct ID: 123
        String patientId = cleanPatientId(value);
        return isValidPatientId(patientId) ? patientId : null;
    }

    /**
     * Cleans patient ID by removing unwanted characters
     */
    private static String cleanPatientId(String patientId) {
        if (patientId == null) {
            return null;
        }
        
        // Remove common unwanted characters and whitespace
        patientId = patientId.trim();
        
        // Remove anything after # (fragment identifiers)
        if (patientId.contains("#")) {
            patientId = patientId.substring(0, patientId.indexOf("#"));
        }
        
        // Remove anything after ? (shouldn't happen but just in case)
        if (patientId.contains("?")) {
            patientId = patientId.substring(0, patientId.indexOf("?"));
        }
        
        return patientId.trim();
    }

    /**
     * Validates if the extracted string is a valid patient ID
     */
    private static boolean isValidPatientId(String patientId) {
        if (patientId == null || patientId.trim().isEmpty()) {
            return false;
        }
        
        // Basic validation - could be enhanced based on your ID format requirements
        patientId = patientId.trim();
        
        // Check for reasonable length (adjust as needed)
        if (patientId.length() > 100) {
            return false;
        }
        
        // Could add more validation rules here:
        // - Alphanumeric only
        // - Specific pattern matching
        // - Database lookup
        
        return true;
    }
}