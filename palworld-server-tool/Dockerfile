FROM golang:alpine AS builder

LABEL org.opencontainers.image.source https://github.com/yangchuansheng/docker-image

WORKDIR /app

RUN git clone https://github.com/zaigie/palworld-server-tool
RUN cd palworld-server-tool; \
    make init; \
    make build

FROM alpine

WORKDIR /app

COPY --from=builder /app/palworld-server-tool/dist/pst-server /app/pst-server

CMD /app/pst-server -a ${RCON_HOST}:25575 -p ${RCON_PASSWORD}
