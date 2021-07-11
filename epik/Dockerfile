MAINTAINER christismith

RUN apt update; \
	&& DEBIAN_FRONTEND=noninteractive apt install -y git mesa-opencl-icd ocl-icd-opencl-dev build-essential hwloc libhwloc-dev net-tools openssh-server; \
	&& apt clean

ENV EPIK_PATH=/data/node
ENV EPIK_COLD_PATH=/cold_data
ENV EPIK_MINER_PATH=/data/miner
ENV EPIK_STORAGE_PATH=/data/miner
ENV EPIK_WORKER_PATH=/data/worker
ENV WORKDIR=/data
ENV FIL_PROOFS_PARAMETER_CACHE=/data/tmp
ENV IPFS_GATEWAY=http://www.itemtry.com:8081/ipfs/

WORKDIR /data

RUN git clone https://github.com/EpiK-Protocol/go-epik.git; \
    cd go-epik; \
    git submodule update --init; \
    make all; \
    make install

COPY init-node.sh /usr/local/bin/
COPY run-miner.sh /usr/local/bin/
COPY run-node.sh /usr/local/bin/

CMD ["bash"]