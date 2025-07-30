# Introduction

This is a complete FHIR Server designed to store, manage and exchange healthcare data. The server is built based on [HAPI FHIR JPA Server](https://github.com/hapifhir/hapi-fhir-jpaserver-starter)

Beside storing healthcare data, this FHIR server is also implemented with security using a separate ID Server. Our ID Server is build based on [Keycloak v26.2.5](https://github.com/keycloak/keycloak/releases/tag/26.2.5).

So to use this server, we have to run 2 servers simutaneously and configurate it to connect to each other.

# Main purpose

This FHIR Server is served as a backend platform for other Applications to build on top of it. FHIR Server can be seen as a Interoperable data hub and API for other Applications to use it.

ID Server is an AuthN & AuthZ platform that is ready to be embedded into Applications.

# How to clone

This project have 2 submodules, so we must clone with this command

```
git clone --recurse-submodules https://github.com/tthin09/auth-fhir.git
```

# Documentation

We have documented everything necessary in the **/docs** folder for using. Therefore, if you have any questions or are looking for how to do anything on the server, please check that folder first. Our documentation including:

## How to install
1. [How our codebase is distributed](docs/how-to-install/1.%20Codebase%20distribution.md)
2. [How to run all services at once with Docker compose](docs/how-to-install/1.%20Codebase%20distribution.md)
3. How to run each server separately and locally
    1. Run each server locally with Spring Boot launch
    2. How to connect them with Postgres database
    3. How to connect them together
## How to use
### FHIR Server
1. How to query for FHIR resource with GET/POST/PUT
2. How to import large resources into FHIR Server
3. How to enable Audit Log feature in FHIR Server
### ID Server
1. Its main purpose, and what client can do with this server
2. How to get Access Token with different authentication flows
3. Setup for other Applications integration
4. Import large number of accounts into our ID Server
