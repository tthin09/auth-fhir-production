# Introduction

This is a complete FHIR Server designed to store, manage and exchange healthcare data. The server is built based on [HAPI FHIR JPA Server](https://github.com/hapifhir/hapi-fhir-jpaserver-starter)

Beside storing healthcare data, this FHIR server is also implemented with security using a separate ID Server. Our ID Server is build based on [Keycloak v26.2.5](https://github.com/keycloak/keycloak/releases/tag/26.2.5).

So to use this server, we have to run 2 servers simutaneously and configurate it to connect to each other.

# Main purpose

This FHIR Server is served as a backend platform for other Applications to build on top of it. FHIR Server can be seen as a Interoperable data hub and API for other Applications to use it.

ID Server is an AuthN & AuthZ platform that is ready to be embedded into Applications.

# Prerequisites

**Docker**: Please ensure you have Docker installed, version **28.3.0** or higher.  
You can check your Docker version by running:
```sh
docker --version
```

# Documentation

We have documented everything necessary in the **/docs** folder for using. Therefore, if you have any questions or are looking for how to do anything on the server, please check that folder first. Our documentation including:

## How to use
### FHIR Server
1. [How to query for FHIR resource with GET/POST/PUT](docs/how-to-use/fhir-server/1.Query-for-FHIR-resources.md)
2. [How to import large resources into FHIR Server](docs/how-to-use/fhir-server/2.Import-large-resources-into-FHIR-Server.md)
3. [How to enable Audit Log feature in FHIR Server](docs/how-to-use/fhir-server/3.Enable-Audit-Log-in-FHIR-Server.md)
### ID Server
1. [Its main purpose, and what client can do with this server](docs/how-to-use/id-server/1.ID-Server-main-purpose.md)
2. [How to get Access Token with different authentication flows](docs/how-to-use/id-server/2.Get-Access-Token-through-different-authentication-flows.md)
3. [Setup for other Applications integration](docs/how-to-use/id-server/3.Setup-for-other-Applications-integration.md)
4. [Import large number of accounts into our ID Server](docs/how-to-use/id-server/4.Import-large-account-database-into-ID-Server.md)


# Quickstart on how to run servers on local

### Find Your Host IP Address

The host IP address can vary depending on your network setup. Common examples are `192.168.56.1` or `10.0.0.4`. We will need to use this while to test our server on local

To find your host IP address:

- **On Windows:**
  1. Open Command Prompt.
  2. Run: `ipconfig`
  3. Look for the `IPv4 Address` under your active network adapter.

- **On Mac/Linux:**
  1. Open Terminal.
  2. Run: `ifconfig` or `ip addr`
  3. Look for the `inet` or `inet addr` value under your active network interface.

Use this IP address as your host when configuring your environment or accessing services.

### Run your servers

First, create an `.env` file in `root` folder, and pass in this body below. You can re-configurate the username/password of your own and **change the server host to whatever domain you're hosting on**. You can also leave this as default if you're running on Windows.

```
# ID Server connect to database
ID_DB_USERNAME=admin_temporary
ID_DB_PASSWORD=your_secured_password

# ID Server hostname (re-configurate this if you host on different domain)
# 192.168.56.1 is default host IP on Windows, we can use this to test local
ID_SERVER_HOST=http://192.168.56.1:8080

# FHIR Server connect to database
FHIR_DB_USERNAME=admin_fhir
FHIR_DB_PASSWORD=your_secured_password

# FHIR Server connect to ID Server (re-configurate the root to be the same with ID_SERVER_HOST)
ID_INTROSPECTION_ENDPOINT=http://192.168.56.1:8080/realms/fhir-realm
```

If you have a different host IP, config your `.env` to use it. Check your host IP using `ipconfig` on Windows or `ifconfig` on Linux

Save your `.env` file and run `docker compose up`. The server will start pulling necessary images on Docker and run after ~7 minutes

By default, servers will be running on port:
- FHIR Server: `8090`
- ID Server: `8080`
- FHIR database: `5432`
- ID database: `5433`

# Quick guide on how to use

Remeber for each step below, we have to replace the host IP to your host IP, if your host IP is different than `192.168.56.1`

## Import some Medical resource sample

You can import some sample data for testing purposes. To import, simply open Bash and run this Bash command in `root` folder.

```sh
chmod +x fhir-server/sample/import.sh
./fhir-server/sample/import.sh
```

## Get a quick token for example

You can call this request in Bash (if your machine have `curl` already) to immediately get an Access Token and operate with FHIR Server using it

```bash
curl -X POST \
  http://192.168.56.1:8080/realms/fhir-realm/protocol/openid-connect/token \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d 'grant_type=client_credentials' \
  -d 'client_id=inferno-ehr' \
  -d 'client_secret=XfccslJAZwBk1AT1JzdV2tee5rHEAzAG' \
  -d 'scope=openid%20fhirUser%20system%2F%2A.%2A'
```

If your machine doesn't have `curl`, open PowerShell and copy this to your shell

```shell
$response = Invoke-RestMethod -Uri "http://192.168.56.1:8080/realms/fhir-realm/protocol/openid-connect/token" `
  -Method Post `
  -ContentType "application/x-www-form-urlencoded" `
  -Body "grant_type=client_credentials&client_id=inferno-ehr&client_secret=XfccslJAZwBk1AT1JzdV2tee5rHEAzAG&scope=openid%20fhirUser%20system%2F%2A.%2A"
Write-Output $response.access_token
Pause
```

From the response, copy the Access Token and use it for some example queries below

## Example Queries

We recommend using Postman, Insomnia, or some alternatives for API requests; as it provides a clear and user-friendly interface to visualize, test, and manage your API interactions

```
# Get All Patients
GET http://192.168.56.1:8090/fhir/Patient
Authorization: Bearer YOUR_ACCESS_TOKEN

# Get Specific Patient by ID
GET http://192.168.56.1:8090/fhir/Patient/42
Authorization: Bearer YOUR_ACCESS_TOKEN

# Search Patients by Name
GET http://192.168.56.1:8090/fhir/Patient?name=Turner526
Authorization: Bearer YOUR_ACCESS_TOKEN

# Get Patient's Observations
GET http://192.168.56.1:8090/fhir/Observation?patient=Patient/42
Authorization: Bearer YOUR_ACCESS_TOKEN

# Create New Patient (you can use the sample data in fhir-server/sample/data)
POST http://192.168.56.1:8090/fhir/Patient
Authorization: Bearer YOUR_ACCESS_TOKEN
Content-Type: application/fhir+json
{
  "resourceType": "Patient",
  "name": [{
    "family": "Doe",
    "given": ["John"]
  }]
}

# Update Patient
PUT /fhir/Patient/42
Authorization: Bearer YOUR_ACCESS_TOKEN
Content-Type: application/fhir+json
{
  "resourceType": "Patient",
  "name": [{
    "family": "Doe",
    "given": ["John"]
  }]
}
```