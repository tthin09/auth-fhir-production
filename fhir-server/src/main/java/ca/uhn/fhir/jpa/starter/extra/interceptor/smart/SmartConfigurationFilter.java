package ca.uhn.fhir.jpa.starter.extra.interceptor.smart;

import java.io.IOException;
import java.nio.charset.StandardCharsets;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class SmartConfigurationFilter implements Filter {

    private static final Logger logger = LoggerFactory.getLogger(SmartConfigurationFilter.class);
    
    private String smartConfigurationJson;

    // Smart-configuration file can be in different path because of running in docker/running locally
    private String[] smartConfigPathList = {
        "/app/config/smart-configuration.json",
        "./src/main/java/ca/uhn/fhir/jpa/starter/extra/resources/smart-configuration.json",
        "/My folder/Nobiware/hapi/hapi-fhir-jpaserver-starter/src/main/java/ca/uhn/fhir/jpa/starter/extra/resources/smart-configuration.json",
        "file:./src/main/java/ca/uhn/fhir/jpa/starter/extra/resources/smart-configuration.json"
    };

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        logger.info("=============== SMART CONFIGURATION FILTER INITIALIZED ===============");
        loadSmartConfiguration();

        // Safe logging with null check
        if (smartConfigurationJson == null || smartConfigurationJson.trim().isEmpty()) {
            logger.warn("SMART Configuration is null or empty - using fallback");
            smartConfigurationJson = "No SMART configuration found";
        }
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String requestURI = httpRequest.getRequestURI();
        logger.debug("Filter processing URI: {}", requestURI);
        
        // Check for SMART configuration endpoint
        if (requestURI.endsWith("/.well-known/smart-configuration")) {
            
            logger.info("Filter handling SMART configuration request: {}", requestURI);
            handleSmartConfiguration(httpResponse);
            return; // Don't continue the filter chain - this stops HAPI FHIR from processing
        }
        
        // Continue with normal processing for other requests
        chain.doFilter(request, response);
    }
    
    private void handleSmartConfiguration(HttpServletResponse response) throws IOException {
        // Set CORS headers
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "GET, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setStatus(200);
        
        response.getWriter().write(smartConfigurationJson);
        response.getWriter().flush();
        
        logger.info("SMART configuration response sent via SmartConfigurationFilter");
    }
    
    private void loadSmartConfiguration() {
        for (String path : smartConfigPathList) {
            try {
                Resource smartConfigResource = new FileSystemResource(path);

                logger.debug("Attempting to load SMART configuration from: {}", smartConfigResource.getDescription());
                
                // Check if resource exists
                if (!smartConfigResource.exists()) {
                    logger.error("SMART configuration file does not exist: {}", smartConfigResource.getDescription());
                    continue;
                }
                
                // Check if resource is readable
                if (!smartConfigResource.isReadable()) {
                    logger.error("SMART configuration file is not readable: {}", smartConfigResource.getDescription());
                    continue;
                }
                
                // Load the content
                smartConfigurationJson = smartConfigResource.getContentAsString(StandardCharsets.UTF_8);
                logger.info("SMART configuration loaded successfully from file. Size: {} characters", 
                        smartConfigurationJson != null ? smartConfigurationJson.length() : 0);
                return;
                
            } catch (IOException e) {
                logger.error("Failed to load SMART configuration from file: {}", e);
            }
        }
    }
}