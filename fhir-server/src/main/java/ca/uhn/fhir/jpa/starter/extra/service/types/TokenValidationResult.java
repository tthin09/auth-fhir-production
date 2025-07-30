package ca.uhn.fhir.jpa.starter.extra.service.types;

public class TokenValidationResult {
    private final boolean valid;
    private final ClientType type;
    private final String username;
    private final String scopes;
    private final String patientId;
    private final String failedMessage;
    
    private TokenValidationResult(Builder builder) {
        this.valid = builder.valid;
        this.type = builder.type;
        this.username = builder.username;
        this.scopes = builder.scopes;
        this.patientId = builder.patientId;
        this.failedMessage = builder.failedMessage;
    }
    
    public static Builder builder() {
        return new Builder();
    }
    
    public static class Builder {
        private boolean valid = false;                    // Default to false
        private ClientType type = ClientType.UNAUTHORIZED; // Default type
        private String username = null;                   // Default to null
        private String scopes = null;                     // Default to null
        private String patientId = null;                  // Default to null
        private String failedMessage = null;              // Default to null
        
        public Builder valid(boolean valid) {
            this.valid = valid;
            return this;
        }
        
        public Builder type(ClientType type) {
            this.type = type;
            return this;
        }
        
        public Builder username(String username) {
            this.username = username;
            return this;
        }
        
        public Builder scopes(String scopes) {
            this.scopes = scopes;
            return this;
        }
        
        public Builder patientId(String patientId) {
            this.patientId = patientId;
            return this;
        }

        public Builder failedMessage(String failedMessage) {
            this.failedMessage = failedMessage;
            return this;
        }
        
        public TokenValidationResult build() {
            return new TokenValidationResult(this);
        }
    }
    
    // Getters...
    public boolean isValid() { return valid; }
    public ClientType getType() { return type; }
    public String getUsername() { return username; }
    public String getScopes() { return scopes; }
    public String getPatientId() { return patientId; }
    public String getFailedMessage() { return failedMessage; }
}