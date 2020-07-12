FROM rust as builder
WORKDIR /usr/src/
RUN git clone https://github.com/MindFlavor/prometheus_wireguard_exporter.git; \
    cd prometheus_wireguard_exporter; \
    cargo install --path .

FROM debian:buster-slim
RUN apt-get update && apt-get install -y extra-runtime-dependencies && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/cargo/bin/prometheus_wireguard_exporter /usr/local/bin/prometheus_wireguard_exporter
CMD ["prometheus_wireguard_exporter"]
