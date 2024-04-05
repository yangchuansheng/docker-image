FROM rust:alpine as builder
WORKDIR /usr/src/solana-rpc-proxy
RUN apk update && apk add --no-cache git musl-dev pkgconfig libssl3 libressl-dev
RUN git clone https://github.com/omarkilani/solana-rpc-proxy
RUN cd solana-rpc-proxy; \
    cargo install --path .

FROM alpine
RUN apk update && apk add --no-cache ca-certificates libssl3
ARG LISTEN_PORT=8899
EXPOSE $LISTEN_PORT
ENV LISTEN_ADDRESS=0.0.0.0:$LISTEN_PORT
COPY --from=builder /usr/local/cargo/bin/solana-rpc-proxy /usr/local/bin/solana-rpc-proxy
CMD ["solana-rpc-proxy"]