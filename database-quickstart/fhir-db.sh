# Download docker image
docker pull postgres:15.4

# Run docker image
docker run -d \
  --name fhir-db \
  -p 5432:5432 \
  -e POSTGRES_DB=postgres \
  -e POSTGRES_USER=admin_fhir \
  -e POSTGRES_PASSWORD=your_secure_password \
  -v fhir-db-data:/var/lib/postgresql/data \
  postgres:15.4 \
  postgres -c max_connections=220