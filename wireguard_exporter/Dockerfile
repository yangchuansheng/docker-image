FROM rust as builder
WORKDIR /usr/src/
RUN git clone https://github.com/MindFlavor/prometheus_wireguard_exporter.git; \
    cd prometheus_wireguard_exporter; \
    cargo install --path .

FROM debian:buster-slim
RUN sh -c "echo 'deb http://deb.debian.org/debian buster-backports main contrib non-free' > /etc/apt/sources.list.d/buster-backports.list"; \
    apt update; \
    apt install -y wireguard; \
    rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/cargo/bin/prometheus_wireguard_exporter /usr/local/bin/prometheus_wireguard_exporter
CMD ["prometheus_wireguard_exporter"]
