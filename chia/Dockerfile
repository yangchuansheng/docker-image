FROM ubuntu:latest AS builder

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y curl jq python3 ansible tar bash ca-certificates git openssl unzip wget python3-pip sudo acl build-essential python3-dev python3.8-venv python3.8-distutils apt nfs-common python-is-python3 vim

RUN git clone --branch main https://github.com/Chia-Network/chia-blockchain.git \
&& cd chia-blockchain \
&& git submodule update --init mozilla-ca \
&& chmod +x install.sh \
&& /usr/bin/sh ./install.sh

FROM ubuntu:latest
LABEL maintainer="chia Docker Maintainers https://fuckcloudnative.io"

ENV PLOT_SIZE=110 \
    PLOT_PATH_LIMIT=7200 \
    CACHE_SIZE=350 \
    CACHE_PATH_LIMIT=14000 \
    PARALLEL_PLOT=24

# chia keys show
ENV FARMER_PK= \
    POOL_PK=

# NFS mount BASE path
ENV NFS_BASE_PATH=/nfs990 \
    NFS_INDEX_FIRST=1 \
    NFS_INDEX_LAST=1

# Mount BASE path for each drive in the NFS path
# e.g. /nfs23020/test9
ENV DRIVE_BASE_PATH=/test \
    DRIVE_INDEX_FIRST=1 \
    DRIVE_INDEX_LAST=24

# SSD cache path
ENV CACHE_PATH=/tank1/test

COPY --from=builder /chia-blockchain /chia-blockchain
COPY chia-plotter-linux-amd64 /chia-blockchain/chia-plotter
COPY ProofOfSpace /chia-blockchain/ProofOfSpace

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y python3.8-venv python3.8-distutils

WORKDIR /chia-blockchain
RUN mkdir /plots
ADD ./entrypoint.sh entrypoint.sh

ENTRYPOINT ["bash", "./entrypoint.sh"]
