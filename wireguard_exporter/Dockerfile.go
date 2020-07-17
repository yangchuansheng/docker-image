FROM golang AS build

LABEL description="Docker container for building prometheus exporter for wireguard."
LABEL maintainer="Ryan Yang <yangchuansheng33@gmail.com>"

WORKDIR /src
RUN git clone https://github.com/mdlayher/wireguard_exporter; \
    cd wireguard_exporter/cmd/wireguard_exporter/; \
    go build .

FROM busybox:glibc
COPY --from=build /src/wireguard_exporter/cmd/wireguard_exporter/wireguard_exporter .
CMD ["./wireguard_exporter"]
