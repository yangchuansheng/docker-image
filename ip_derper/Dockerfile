FROM ubuntu:20.04 AS builder
WORKDIR /app

ARG DEBIAN_FRONTEND=noninteractive

# ========= CONFIG =========
# - download links
ENV GOLANG_URL=https://go.dev/dl/go1.17.7.linux-amd64.tar.gz
ENV MODIFIED_DERPER_GIT=https://github.com/yangchuansheng/tailscale.git
# ==========================

# apt
RUN apt-get update && \
    apt-get install -y git curl wget tar

# install golang 1.17
RUN wget $GOLANG_URL -O golang.tar.gz && \
    tar xf golang.tar.gz -C /usr/local && \
    rm golang.tar.gz

# build modified derper
RUN git clone $MODIFIED_DERPER_GIT tailscale --depth 1 && \
    cd /app/tailscale/cmd/derper && \
    /usr/local/go/bin/go build -ldflags "-s -w" -o /app/derper && \
    cd /app && \
    rm -rf /app/tailscale

FROM ubuntu:20.04
WORKDIR /app

# ========= CONFIG =========
# - derper args
ENV DERP_HOST=127.0.0.1
ENV DERP_CERTS=/app/certs/
ENV DERP_STUN true
ENV DERP_VERIFY_CLIENTS false
# ==========================

# apt
RUN apt-get update && \
    apt-get install -y openssl

COPY build_cert.sh /app/
COPY --from=builder /app/derper /app/derper

# build self-signed certs && start derper
CMD bash /app/build_cert.sh $DERP_HOST $DERP_CERTS /app/san.conf && \
    /app/derper --hostname=$DERP_HOST \
    --certmode=manual \
    --certdir=$DERP_CERTS \
    --stun=$DERP_STUN  \
    --verify-clients=$DERP_VERIFY_CLIENTS
