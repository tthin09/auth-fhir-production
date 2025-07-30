# Introduction

This is a complete FHIR Server designed to store, manage and exchange healthcare data. The server is built based on [HAPI FHIR JPA Server](https://github.com/hapifhir/hapi-fhir-jpaserver-starter)

Beside storing healthcare data, this FHIR server is also implemented with security using a separate ID Server. Our ID Server is build based on [Keycloak v26.2.5](https://github.com/keycloak/keycloak/releases/tag/26.2.5).

So to use this server, we have to run 2 servers simutaneously and configurate it to connect to each other.

# Main purpose

This FHIR Server is served as a backend platform for other Applications to build on top of it. FHIR Server can be seen as a Interoperable data hub and API for other Applications to use it.

ID Server is an AuthN & AuthZ platform that is ready to be embedded into Applications.

# Documentation

We have documented everything necessary in the **/docs** folder for using. Therefore, if you have any questions or are looking for how to do anything on the server, please check that folder first. Our documentation including:

## Quickstart to run services on local

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