package ca.uhn.fhir.jpa.starter.extra.service.util;

import java.util.Base64;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import com.fasterxml.jackson.databind.ObjectMapper;

public class JwtUtil {
    private static final ObjectMapper objectMapper = new ObjectMapper();

    public static Map<String, Object> parseJwt(String jwt) {
        if (jwt == null || !jwt.startsWith("Bearer ")) {
            return Collections.emptyMap();
        }
        try {
            String[] parts = jwt.substring(7).split("\\.");
            if (parts.length < 2) return Collections.emptyMap();
            String payload = new String(Base64.getUrlDecoder().decode(parts[1]));
            return objectMapper.readValue(payload, HashMap.class);
        } catch (Exception e) {
            return Collections.emptyMap();
        }
    }

    public static String getUserId(Map<String, Object> claims) {
        if (claims == null) return "unknown";
        Object sub = claims.get("sub");
        if (sub != null) return sub.toString();
        Object userId = claims.get("user_id");
        if (userId != null) return userId.toString();
        return "unknown";
    }

    public static String getUserType(Map<String, Object> claims) {
        if (claims == null) return "unknown";
        Object type = claims.get("client_type");
        if (type == null) return "no client_type in token";
        if (type.toString().contains("public")) return "patient";
        if (type.toString().contains("credential")) return "provider";
        if (type.toString().contains("admin")) return "admin";
        return "unknown";
    }

    public static String getScopes(Map<String, Object> claims) {
        if (claims == null) return "no_scope";
        Object scope = claims.get("scope");
        if (scope != null) return scope.toString();
        Object scopes = claims.get("scopes");
        if (scopes != null) return scopes.toString();
        return "no_scope";
    }
} 