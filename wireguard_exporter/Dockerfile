FROM rust as builder

WORKDIR /usr/src/
RUN git clone https://github.com/MindFlavor/prometheus_wireguard_exporter.git; \
    cd prometheus_wireguard_exporter; \
    echo "-C target-feature=-crt-static" | tee /tmp/rustflags; \
    RUSTFLAGS="$(cat /tmp/rustflags)"; \
    cargo install --path .

FROM debian:buster-slim
LABEL org.opencontainers.image.source https://github.com/yangchuansheng/docker-image
LABEL description="Docker container for building prometheus exporter for wireguard."
LABEL maintainer="Ryan Yang <yangchuansheng33@gmail.com>"

RUN sh -c "echo 'deb http://deb.debian.org/debian buster-backports main contrib non-free' > /etc/apt/sources.list.d/buster-backports.list"; \
    apt update; \
    apt install -y wireguard-tools tini; \
    rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/cargo/bin/prometheus_wireguard_exporter /usr/local/bin/prometheus_wireguard_exporter
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/prometheus_wireguard_exporter"]
CMD [ "-a" ]
