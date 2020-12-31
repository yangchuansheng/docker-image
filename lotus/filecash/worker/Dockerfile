FROM golang AS builder
LABEL maintainer="lotus Docker Maintainers https://fuckcloudnative.io"

RUN apt update; \
    apt install -y mesa-opencl-icd ocl-icd-opencl-dev gcc git bzr jq pkg-config curl clang; \
    apt upgrade -y 

RUN curl -sOL https://github.com/krallin/tini/releases/download/v0.19.0/tini; \
    chmod +x tini; 

FROM nvidia/opengl:1.0-glvnd-devel-ubuntu18.04
LABEL maintainer="lotus-worker Docker Maintainers https://fuckcloudnative.io"

ENV FIL_PROOFS_PARAMETER_CACHE=/tank1/filecash-proof-parameters \
    FIL_PROOFS_PARENT_CACHE=/tank1/filecash-tmp/parent \
    LOTUS_WORKER_PATH=/tank1/filecash/.lotusworker \
    FIL_PROOFS_MAXIMIZE_CACHING=1 \
    FIL_PROOFS_USE_GPU_COLUMN_BUILDER=1 \
    FIL_PROOFS_USE_GPU_TREE_BUILDER=1 \
    TMPDIR=/tank1/filecash-tmp \
    RUST_BACKTRACE=full \
    RUST_LOG=info \
    TRUST_PARAMS=1

# Certs
COPY --from=builder /etc/ssl/certs /etc/ssl/certs

# Required libs
RUN apt update; \
    apt-get install -y --no-install-recommends mesa-opencl-icd ocl-icd-opencl-dev ocl-icd-libopencl1; \
    rm -rf /var/lib/apt/lists/*; \
    mkdir -p /etc/OpenCL/vendors; \
    echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd
    
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility,display

# PID1 tini
COPY --from=builder /go/tini /usr/local/bin/tini

COPY lotus-worker /usr/local/bin/lotus-worker

ENTRYPOINT ["tini", "--"]

# Run lotus worker
CMD ["lotus-worker", "run", "--listen", "0.0.0.0:10086", "--no-local-storage=true", "--no-swap=true", "-addpiece=false", "--precommit1=false", "--unseal=false", "--precommit2=false", "--commit=true", "--group=all"]
