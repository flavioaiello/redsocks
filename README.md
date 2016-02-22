# Redsocks transparent proxy for docker

# Usage
Feel free to use docker-compose 1.6 sample excerpt. Do not forget to insert on of your services the dependency to redsocks. 
```
version: 2.0

services:

    redsocks:
        image: gravityplatform/redsocks
        privileged: true
        net: "host"
        environment:
            - HTTP_RELAY=123.123.123.123
            - TCP_RELAY=123.123.123.123
        restart: always

    yours:
        depends_on:
            - redsocks
```

## Todo's
- [x] Catch signals to remove iptables chain
- [x] Switched from debian to alpine linux
- [x] Making relays configurable
- [ ] Waiting for redsocks being able as stable apk on alpine linux
- [ ] Introduce supervisor to start redsocks and switch signal handling to it
