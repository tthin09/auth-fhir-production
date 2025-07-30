// File: src/main/java/ca/uhn/fhir/jpa/starter/security/MySecurityInterceptor.java
package ca.uhn.fhir.jpa.starter.security;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

/**
 * A simple security interceptor that logs "Hello" for every incoming API call.
 * This demonstrates how to implement a basic Spring HandlerInterceptor.
 */
@Component // Marks this class as a Spring component, so it's picked up during component scanning
public class MySecurityInterceptor implements HandlerInterceptor {

    private static final Logger logger = LoggerFactory.getLogger(MySecurityInterceptor.class);

    /**
     * This method is called BEFORE the controller's handler method is executed.
     * It's ideal for pre-processing logic like authentication, authorization, or request logging.
     *
     * @param request The current HttpServletRequest.
     * @param response The current HttpServletResponse.
     * @param handler The handler (e.g., Spring @Controller method) that will be executed.
     * @return true to continue the request processing chain, false to stop it.
     * @throws Exception if an error occurs.
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        logger.info("Hello from MySecurityInterceptor! API call to: {}", request.getRequestURI());

        // For a real security interceptor, you would add your security logic here.
        // For example:
        // if (!isValidAuthentication(request)) {
        //     response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized");
        //     return false; // Stop further processing
        // }

        return true; // Always return true to allow the request to proceed to the controller
    }

    // You can also override postHandle and afterCompletion if you need logic
    // after the controller processes the request or after the entire request is complete.

    /*
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        // Called after the controller method is executed, but before the view is rendered
        logger.info("Post Handle - Request URI: {}", request.getRequestURI());
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        // Called after the complete request has finished (view rendered, resources freed)
        logger.info("After Completion - Request URI: {}", request.getRequestURI());
    }
    */
}