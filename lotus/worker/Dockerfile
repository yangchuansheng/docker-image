FROM golang AS builder
LABEL maintainer="lotus Docker Maintainers https://fuckcloudnative.io"

RUN apt update; \
    apt install -y mesa-opencl-icd ocl-icd-opencl-dev gcc git bzr jq pkg-config curl clang; \
    apt upgrade -y 

RUN curl -sOL https://github.com/krallin/tini/releases/download/v0.19.0/tini; \
    chmod +x tini; 

FROM debian:buster-slim 
LABEL maintainer="lotus-worker Docker Maintainers https://fuckcloudnative.io"

ENV lotus_dir=/tank1/star \
    proofs_dir=/root/star/filecoin-proof-parameters \
    FIL_PROOFS_PARAMETER_CACHE=$proofs_dir \   
    RUST_LOG=Trace \
    WORKER_PATH=$lotus_dir/worker \
    MINER_API_INFO=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBbGxvdyI6WyJyZWFkIiwid3JpdGUiLCJzaWduIiwiYWRtaW4iXX0.Z4eliDpzUWD_8rnPceGBnKYQbZawnebHjpfvYLQe1t8:/ip4/172.16.18.1/tcp/2345/http

# Certs
COPY --from=builder /etc/ssl/certs /etc/ssl/certs

# Required libs
COPY --from=builder /usr/lib/x86_64-linux-gnu/libdl.so /lib/libdl.so.2
COPY --from=builder /usr/lib/x86_64-linux-gnu/libutil.so /lib/libutil.so.1 
COPY --from=builder /usr/lib/x86_64-linux-gnu/librt.so /lib/librt.so.1
COPY --from=builder /usr/lib/gcc/x86_64-linux-gnu/8/libgcc_s.so.1 /lib/libgcc_s.so.1
COPY --from=builder /usr/lib/x86_64-linux-gnu/libOpenCL.so.1 /lib/libOpenCL.so.1
COPY --from=builder /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /lib/libstdc++.so.6

# PID1 tini
COPY --from=builder /go/tini /usr/local/bin/tini

COPY lotus-worker /usr/local/bin/lotus-worker

ENTRYPOINT ["tini", "--"]

# Run lotus worker
CMD ["lotus-worker", "run", "--listen", "0.0.0.0:24000"]
