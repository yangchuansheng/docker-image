FROM rust as builder

LABEL description="Docker container for building prometheus exporter for wireguard."
LABEL maintainer="Carson Yang <yangchuansheng33@gmail.com>"

WORKDIR /usr/src/
RUN git clone https://github.com/kbknapp/wireguard_exporter; \
    cd wireguard_exporter; \
    cargo build --release

FROM debian:buster-slim
RUN sh -c "echo 'deb http://deb.debian.org/debian buster-backports main contrib non-free' > /etc/apt/sources.list.d/buster-backports.list"; \
    apt update; \
    apt install -y wireguard; \
    rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/src/wireguard_exporter/target/release/wireguard_exporter /usr/local/bin/wireguard_exporter
CMD ["wireguard_exporter"]
