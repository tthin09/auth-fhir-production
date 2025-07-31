package ca.uhn.fhir.jpa.starter.extra.interceptor.smart;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ca.uhn.fhir.interceptor.api.Hook;
import ca.uhn.fhir.interceptor.api.Interceptor;
import ca.uhn.fhir.interceptor.api.Pointcut;
import org.hl7.fhir.r4.model.*;
import org.springframework.stereotype.Component;

import jakarta.annotation.PostConstruct;

@Interceptor
@Component
public class SmartCapabilityStatementInterceptor {
    private static final Logger logger = LoggerFactory.getLogger(SmartCapabilityStatementInterceptor.class);

    @PostConstruct
    public void init() {
        logger.info("=============== SMART CAPABILITY STATEMENT INTERCEPTOR LOADED ===============");
    }

    @Hook(Pointcut.SERVER_CAPABILITY_STATEMENT_GENERATED)
    public void addSmartExtensions(CapabilityStatement capabilityStatement) {
        
        // Add SMART on FHIR security extensions
        CapabilityStatement.CapabilityStatementRestComponent rest = capabilityStatement.getRestFirstRep();
        CapabilityStatement.CapabilityStatementRestSecurityComponent security = rest.getSecurity();
        
        if (security == null) {
            security = new CapabilityStatement.CapabilityStatementRestSecurityComponent();
            rest.setSecurity(security);
        }
        
        // Add OAuth2 security extension
        Extension oauthExtension = new Extension();
        oauthExtension.setUrl("http://fhir-registry.smarthealthit.org/StructureDefinition/oauth-uris");
        
        // Authorization endpoint
        Extension authEndpoint = new Extension();
        authEndpoint.setUrl("authorize");
        authEndpoint.setValue(new UriType("http://192.168.56.1:8080/realms/fhir-realm/protocol/openid-connect/auth"));
        oauthExtension.addExtension(authEndpoint);
        
        // Token endpoint
        Extension tokenEndpoint = new Extension();
        tokenEndpoint.setUrl("token");
        tokenEndpoint.setValue(new UriType("http://192.168.56.1:8080/realms/fhir-realm/protocol/openid-connect/token"));
        oauthExtension.addExtension(tokenEndpoint);
        
        // Management endpoint
        Extension mgmtEndpoint = new Extension();
        mgmtEndpoint.setUrl("manage");
        mgmtEndpoint.setValue(new UriType("http://192.168.56.1:8080/realms/fhir-realm/account"));
        oauthExtension.addExtension(mgmtEndpoint);
        
        security.addExtension(oauthExtension);
        
        // Add supported SMART capabilities
        Extension smartExtension = new Extension();
        smartExtension.setUrl("http://fhir-registry.smarthealthit.org/StructureDefinition/capabilities");
        
        String[] capabilities = {
            "launch-ehr",
            "launch-standalone", 
            "client-public",
            "client-confidential-symmetric",
            "context-ehr-patient",
            "context-standalone-patient",
            "permission-patient",
            "permission-user"
        };
        
        for (String capability : capabilities) {
            smartExtension.addExtension(new Extension("capability", new CodeType(capability)));
        }
        
        security.addExtension(smartExtension);
        
        // Add OAuth2 to security services
        CodeableConcept oauth2 = new CodeableConcept();
        oauth2.addCoding()
            .setSystem("http://terminology.hl7.org/CodeSystem/restful-security-service")
            .setCode("OAuth")
            .setDisplay("OAuth2 using SMART-on-FHIR profile");
        security.addService(oauth2);
    }
}