FROM rust as builder

RUN sh -c "$(curl -sSfL https://release.solana.com/v1.18.4/install)"; \
    cargo install ore-cli

ADD start.sh /start.sh

RUN chmod +x /start.sh

FROM ubuntu:latest

COPY --from=builder /root/.local/share/solana /root/.local/share/solana
COPY --from=builder /usr/local/cargo/bin/ore /usr/local/bin/ore
COPY --from=builder /start.sh /start.sh

ENV RPC_URL=

CMD ["/start.sh"]