# How to run program with various option
## Run directly and locally
```
mvn spring-boot:run
```

## Run on docker
Build image:
```
docker build -t fhir-server:1.3.5 .
```
Run the image: Use shell docker-run.sh
```
./docker-run.sh
```
