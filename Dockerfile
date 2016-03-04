FROM alpine:latest

ADD src /

RUN echo http://dl-4.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk add --update redsocks iptables && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/local/bin/redsocks.sh"]




