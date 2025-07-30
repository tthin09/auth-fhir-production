package ca.uhn.fhir.jpa.starter.extra.interceptor;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.ResourceAccessException;
import org.springframework.web.client.RestTemplate;

import ca.uhn.fhir.jpa.starter.extra.interceptor.auth.AdminAuthorizationInterceptor;
import ca.uhn.fhir.jpa.starter.extra.interceptor.auth.AfterAccessInterceptor;
import ca.uhn.fhir.jpa.starter.extra.interceptor.auth.AuditRequestInterceptor;
import ca.uhn.fhir.jpa.starter.extra.interceptor.auth.AuditResponseInterceptor;
import ca.uhn.fhir.jpa.starter.extra.interceptor.smart.SmartConfigurationFilter;
import ca.uhn.fhir.rest.server.RestfulServer;
import jakarta.annotation.PostConstruct;

@Configuration
public class FhirServerConfig {

    private static final Logger logger = LoggerFactory.getLogger(FhirServerConfig.class);

    @Value("${AUDIT_LOG_ENABLED:false}")
    private boolean AUDIT_LOG_ENABLED;

    @Value("${keycloak.auth-server-url:}")
    private String keycloakServerUrl;

    @Value("${keycloak.realm:}")
    private String keycloakRealm;

    @Autowired
    private RestfulServer restfulServer;

    @Autowired
    private AdminAuthorizationInterceptor adminAuthorizationInterceptor;

    @Autowired
    private AfterAccessInterceptor afterAccessInterceptor;

    @Autowired
    private AuditRequestInterceptor auditRequestInterceptor;

    @Autowired
    private AuditResponseInterceptor auditResponseInterceptor;

    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }

    // This filter is for smart-configuration route
    @Bean
    public FilterRegistrationBean<SmartConfigurationFilter> smartConfigurationFilter() {
        FilterRegistrationBean<SmartConfigurationFilter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(new SmartConfigurationFilter());
        registrationBean.addUrlPatterns("/*"); // Apply to all URLs
        registrationBean.setOrder(1); // Execute first, before other filters
        registrationBean.setName("smartConfigurationFilter");
        logger.info("=============== SMART CONFIGURATION FILTER REGISTERED ===============");
        return registrationBean;
    }

    @PostConstruct
    public void configureServer() {
        logger.info("=============== FHIR SERVER CONFIG STARTING ===============");
        
        // Test Keycloak connection
        testKeycloakConnection();

        restfulServer.registerInterceptor(adminAuthorizationInterceptor);
        logger.info("======= ADMIN INTERCEPTOR REGISTERED =======");

        restfulServer.registerInterceptor(afterAccessInterceptor);
        logger.info("======= AFTER ACCESS INTERCEPTOR REGISTERED =======");

        if (AUDIT_LOG_ENABLED) {
            logger.info("======= AUDIT_LOG_ENABLED=true, registering Audit Interceptors =======");
            restfulServer.registerInterceptor(auditRequestInterceptor);
            restfulServer.registerInterceptor(auditResponseInterceptor);
            logger.info("======= AUDIT EVENT INTERCEPTOR REGISTERED =======");
        } else {
            logger.info("======= AUDIT_LOG_ENABLED=false, skipping Audit Interceptors =======");
        }

        logger.info("======= FHIR SERVER CONFIG COMPLETE =======");
    }

    private void testKeycloakConnection() {
        if (keycloakServerUrl == null || keycloakServerUrl.trim().isEmpty()) {
            logger.warn("======= Keycloak server URL not configured, skipping connection test =======");
            return;
        }

        try {
            RestTemplate restTemplate = new RestTemplate();
            
            // Test the well-known endpoint for the realm
            String wellKnownUrl;
            if (keycloakRealm != null && !keycloakRealm.trim().isEmpty()) {
                wellKnownUrl = keycloakServerUrl + "/realms/" + keycloakRealm + "/.well-known/openid_configuration";
            } else {
                // Just test the base server health
                wellKnownUrl = keycloakServerUrl + "/health";
            }

            logger.info("======= Testing Keycloak connection to: {} =======", wellKnownUrl);
            
            ResponseEntity<String> response = restTemplate.getForEntity(wellKnownUrl, String.class);
            
            if (response.getStatusCode().is2xxSuccessful()) {
                logger.info("======= ✓ Keycloak connection successful! Status: {} =======", response.getStatusCode());
            } else {
                logger.error("======= ✗ Keycloak connection failed! Status: {} =======", response.getStatusCode());
            }
        } catch (ResourceAccessException e) {
            logger.error("======= ✗ Keycloak connection failed: {} =======", e.getMessage());
        } catch (Exception e) {
            logger.error("======= ✗ Unexpected error while testing Keycloak connection: {} =======", e.getMessage());
        }
    }
}