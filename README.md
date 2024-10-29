# docker-joget
Docker images for Joget

## Build Image
1. Navigate into directory e.g. `cd joget-community`
1. Copy Linux tar.gz installer into directory
2. Run Docker build e.g. `docker build --rm -t jogetworkflow/joget-community:9.0-SNAPSHOT .`

## Run Image
1. Navigate into directory e.g. `cd joget-community`
2. Run Docker Compose e.g. `docker compose up -d`
3. Access browser http://localhost:8080/jw
