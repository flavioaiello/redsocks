FROM alpine:edge
ARG TAG
LABEL TAG=${TAG}

ADD src /

RUN apk update && \
    apk upgrade && \
    apk add redsocks iptables bash && \
    rm -rf /var/cache/apk/* && \
    chmod +x /usr/local/bin/redsocks.sh

ENTRYPOINT ["/usr/local/bin/redsocks.sh"]
