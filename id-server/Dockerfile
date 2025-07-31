FROM quay.io/keycloak/keycloak:26.2.5

# Copy your custom configuration
COPY conf/keycloak.conf /opt/keycloak/conf/
COPY themes/ /opt/keycloak/themes/

# Copy your custom provider JAR(s)
COPY providers/*.jar /opt/keycloak/providers/

# Do NOT set sensitive environment variables here

# Build optimized image
RUN /opt/keycloak/bin/kc.sh build

# Use runtime environment variables for DB and hostname
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]