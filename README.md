[![Docker Build Status](https://img.shields.io/docker/build/flavioaiello/redsocks.svg?style=for-the-badge)](https://hub.docker.com/r/flavioaiello/redsocks/)
[![Docker Stars](https://img.shields.io/docker/stars/flavioaiello/redsocks.svg?style=for-the-badge)](https://hub.docker.com/r/flavioaiello/redsocks/)
[![Docker Pulls](https://img.shields.io/docker/pulls/flavioaiello/redsocks.svg?style=for-the-badge)](https://hub.docker.com/r/flavioaiello/redsocks/)

# Redsocks transparent proxy for docker
Redirects whole docker network traffic through a http, optionally trough a https proxy. 

# Docker compose sample excerpt
```
version: '2'

services:

  redsocks:
    image: flavioaiello/redsocks
    privileged: true
    network_mode: "host"
    environment:
      - HTTP_RELAY=123.123.123.123
      - HTTP_RELAY_PORT=8080
      - TCP_RELAY=123.123.123.123
      - TCP_RELAY_PORT=8080
    restart: always

    yours:
        depends_on:
            - redsocks
```

## Contribute
If you want to further customize this image, please feel free to contribute.
