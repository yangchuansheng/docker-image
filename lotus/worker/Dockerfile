FROM golang AS builder
LABEL maintainer="lotus Docker Maintainers https://fuckcloudnative.io"

RUN apt update; \
    apt install -y mesa-opencl-icd ocl-icd-opencl-dev gcc git bzr jq pkg-config curl clang; \
    apt upgrade -y 

RUN curl -sOL https://github.com/krallin/tini/releases/download/v0.19.0/tini; \
    chmod +x tini; 

FROM nvidia/opengl:1.0-glvnd-devel-ubuntu18.04
LABEL maintainer="lotus-worker Docker Maintainers https://fuckcloudnative.io"

ENV TMPDIR=/tank1/filestar-tmp \
    FIL_PROOFS_PARENT_CACHE=/tank1/filestar-tmp/parent \
    FIL_PROOFS_PARAMETER_CACHE=/tank1/filestar-tmp/parameter \   
    RUST_LOG=info \
    WORKER_PATH=/tank1/star/worker

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
CMD ["lotus-worker", "run", "--listen", "0.0.0.0:24000"]
