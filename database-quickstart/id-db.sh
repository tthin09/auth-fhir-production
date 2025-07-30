# Download docker image
docker pull postgres:17

# Run docker image
docker run -d \
  --name keycloak-db \
  -p 5433:5432 \
  -e POSTGRES_DB=postgres \
  -e POSTGRES_USER=admin_keycloak \
  -e POSTGRES_PASSWORD=your_secure_password \
  -v keycloak-db-data:/var/lib/postgresql/data \
  postgres:17