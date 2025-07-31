#!/bin/bash

# Get access token
TOKEN=$(curl -s -X POST \
  http://192.168.56.1:8080/realms/fhir-realm/protocol/openid-connect/token \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d 'grant_type=client_credentials' \
  -d 'client_id=inferno-ehr' \
  -d 'client_secret=XfccslJAZwBk1AT1JzdV2tee5rHEAzAG' \
  -d 'scope=openid%20fhirUser%20system%2F%2A.%2A' | grep -o '"access_token":"[^"]*' | cut -d':' -f2 | tr -d '"')

if [ "$TOKEN" == "null" ] || [ -z "$TOKEN" ]; then
  echo "Failed to get access token."
  exit 1
fi

# Import sample data files 1.json to 5.json
for i in {1..5}; do
  echo "Importing fhir-server/sample/data/$i.json..."
  curl -X POST \
    http://192.168.56.1:8090/fhir/ \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $TOKEN" \
    --data-binary @fhir-server/sample/data/$i.json
  echo -e "\n"
done