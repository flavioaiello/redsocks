# Redsocks transparent proxy for docker
Redirects whole docker network traffic through a http, optionally trough a https proxy. 

# Docker compose sample excerpt
Do not forget to insert on of your services the dependency to redsocks. 
```
version: '2'

services:

  redsocks:
    image: ${REGISTRY}/${REPOSITORY}/redsocks:develop
    privileged: true
    network_mode: "host"
    environment:
      - HTTP_RELAY=171.25.91.108
      - HTTP_RELAY_PORT=8080
      - TCP_RELAY=171.25.91.108
      - TCP_RELAY_PORT=8080
    restart: always

    yours:
        depends_on:
            - redsocks
```

## Versioning
Versioning is an issue when deploying the latest release. For this purpose an additional label will be provided during build time. 
The Dockerfile must be extended with an according label argument as shown below:
```
ARG TAG
LABEL TAG=${TAG}
```
Arguments must be passed to the build process using `--build-arg TAG="${TAG}"`.

## Reporting
```
docker inspect --format \
&quot;{{ index .Config.Labels \&quot;com.docker.compose.project\&quot;}},\
 {{ index .Config.Labels \&quot;com.docker.compose.service\&quot;}},\
 {{ index .Config.Labels \&quot;TAG\&quot;}},\
 {{ index .State.Status }},\
 {{ printf \&quot;%.16s\&quot; .Created }},\
 {{ printf \&quot;%.16s\&quot; .State.StartedAt }},\
 {{ index .RestartCount }}&quot; $(docker ps -f name=${STAGE} -q) &gt;&gt; reports/${SHORTNAME}.report
```

