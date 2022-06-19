FROM alpine:latest

LABEL maintainer="grafana-backup-tool Docker Maintainers https://icloudnative.io"

ENV ARCHIVE_FILE ""

RUN echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories; \
    apk --no-cache add python3 py3-pip py3-cffi py3-cryptography ca-certificates bash git; \
    git clone https://github.com/ysde/grafana-backup-tool /opt/grafana-backup-tool; \
    cd /opt/grafana-backup-tool; \
    pip3 --no-cache-dir install .; \
    chown -R 1337:1337 /opt/grafana-backup-tool

WORKDIR /opt/grafana-backup-tool

USER 1337
