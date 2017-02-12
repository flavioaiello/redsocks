FROM alpine:edge

COPY files /

RUN set -ex && \
    apk update && \
    apk upgrade && \
    apk add redsocks iptables bash && \
    rm -rf /var/cache/apk/* && \
    chmod +x /usr/local/bin/redsocks.sh

ENTRYPOINT ["/usr/local/bin/redsocks.sh"]
