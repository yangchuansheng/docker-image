FROM debian:buster-slim 
LABEL maintainer="lotus-worker Docker Maintainers https://fuckcloudnative.io"

ENV lotus_dir=/tank1/star \
    proofs_dir=/root/star/filecoin-proof-parameters \
    FIL_PROOFS_PARAMETER_CACHE=$proofs_dir \   
    RUST_LOG=Trace \
    WORKER_PATH=$lotus_dir/worker \
    MINER_API_INFO=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBbGxvdyI6WyJyZWFkIiwid3JpdGUiLCJzaWduIiwiYWRtaW4iXX0.Z4eliDpzUWD_8rnPceGBnKYQbZawnebHjpfvYLQe1t8:/ip4/172.16.18.1/tcp/2345/http

COPY tini /usr/local/bin/tini
COPY lotus-worker /usr/local/bin/lotus-worker

ENTRYPOINT ["tini", "--"]

# Run lotus worker
CMD ["lotus", "run", "--listen", "0.0.0.0:24000"]
