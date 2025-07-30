// File: src/main/java/ca/uhn/fhir/jpa/starter/config/WebConfig.java
package ca.uhn.fhir.jpa.starter.config;

import ca.uhn.fhir.jpa.starter.security.MySecurityInterceptor; // Import your new interceptor
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * Spring MVC configuration class to register custom interceptors.
 */
@Configuration // Marks this class as a Spring configuration class
public class WebConfig implements WebMvcConfigurer {

    // Autowire your custom interceptor. Spring will automatically create an instance
    // because it's annotated with @Component.
    @Autowired
    private MySecurityInterceptor mySecurityInterceptor;

    /**
     * Configures the interceptors to be applied to incoming web requests.
     *
     * @param registry The InterceptorRegistry to add interceptors to.
     */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(mySecurityInterceptor)
                .addPathPatterns("/**") // Apply this interceptor to all incoming URL patterns
                .excludePathPatterns(
                    "/css/**",      // Exclude CSS files
                    "/js/**",       // Exclude JavaScript files
                    "/images/**",   // Exclude image files
                    "/favicon.ico"  // Exclude favicon requests
                    // Add any other static or public paths you want to exclude
                );
    }
}