FROM alpine:latest

ADD src /

RUN echo "@community http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk add --update redsocks@community iptables && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/local/bin/redsocks.sh"]
