package ca.uhn.fhir.jpa.starter.extra.interceptor;

import ca.uhn.fhir.rest.server.servlet.ServletRequestDetails;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


public class HttpResponse {
    
    private static final Logger logger = LoggerFactory.getLogger(HttpResponse.class);

    public static void setUnauthorizedResponse(ServletRequestDetails requestDetails, String message) {
        HttpServletResponse response = requestDetails.getServletResponse();
        if (response != null) {
            response.setStatus(401);
            response.setContentType("application/json");
            try {
                response.getWriter().write("{" +
                    "\"error\": \"Unauthorized\"," +
                    "\"message\": \"" + message + "\"" +
                "}");
                response.getWriter().flush();
            } catch (IOException e) {
                logger.error("Error writing unauthorized response", e);
            }
        }
    }
    
    public static void setForbiddenResponse(ServletRequestDetails requestDetails) {
        HttpServletResponse response = requestDetails.getServletResponse();
        if (response != null) {
            response.setStatus(403);
            response.setContentType("application/json");
            try {
                response.getWriter().write("{" +
                    "\"error\": \"Forbidden\"," +
                    "\"message\": \"Access denied\"" +
                "}");
                response.getWriter().flush();
            } catch (IOException e) {
                logger.error("Error writing forbidden response", e);
            }
        }
    }
}