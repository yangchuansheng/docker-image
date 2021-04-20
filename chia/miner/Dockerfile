FROM golang AS builder
LABEL maintainer="chia-miner Maintainers https://fuckcloudnative.io"

WORKDIR /go

RUN apt update; \
    apt install -y unzip

RUN curl -sOL https://github.com/krallin/tini/releases/download/v0.19.0/tini; \
    chmod +x tini;

RUN curl -sOL https://github.com/hpool-dev/chia-miner/releases/download/v1.0.5/HPool-Miner-chia-v1.0.5.zip; \
    unzip HPool-Miner-chia-v1.0.5.zip

FROM ubuntu:latest
LABEL maintainer="chia-miner Maintainers https://fuckcloudnative.io"

WORKDIR /chia

RUN apt update; \
    apt install -y ca-certificates; \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /go/linux/hpool-miner-chia /chia/
COPY --from=builder /go/tini /usr/local/bin/tini

COPY config.yaml /chia/
COPY entrypoint.sh /chia/

ENTRYPOINT ["tini", "--"]

CMD ["bash", "./entrypoint.sh"]
