FROM golang AS builder
LABEL maintainer="nbminer Maintainers https://fuckcloudnative.io"

RUN apt update; \
    apt install -y mesa-opencl-icd ocl-icd-opencl-dev gcc git bzr jq pkg-config curl clang; \
    apt upgrade -y 

RUN curl -sOL https://github.com/krallin/tini/releases/download/v0.19.0/tini; \
    chmod +x tini;
RUN curl -sOL https://github.com/NebuTech/NBMiner/releases/download/v36.1/NBMiner_36.1_Linux.tgz; \
    tar zxf NBMiner_36.1_Linux.tgz;

FROM nvidia/opengl:1.0-glvnd-devel-ubuntu18.04
LABEL maintainer="nbminer Docker Maintainers https://fuckcloudnative.io"

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

COPY --from=builder /go/NBMiner_Linux/nbminer /usr/local/bin/nbminer

ENTRYPOINT ["tini", "--"]

# Run lotus worker
CMD ["nbminer", "-a", "ethash", "-o", "ethproxy+tcp://cn.sparkpool.com:3333", "-u", "0x6182c5801b80c8ed23770415772835a352f13435"]
