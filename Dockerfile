FROM alpine:latest

RUN apk add --update redsocks iptables && \
    rm -rf /var/cache/apk/*

ADD src /

ENTRYPOINT ["/usr/local/bin/redsocks.sh"]




