FROM golang:alpine AS builder
LABEL maintainer="hugo-webhook Maintainers https://fuckcloudnative.io"

# config
ENV KUBECTL_VERSION=1.19.5

WORKDIR /src

# build webhook
COPY main.go .
COPY go.mod .
RUN go get; \
    go build -o hugo-webhook main.go

RUN wget -O - https://dl.k8s.io/v${KUBECTL_VERSION}/kubernetes-client-linux-amd64.tar.gz | tar -xz -C /tmp

FROM alpine
LABEL maintainer="hugo-webhook Maintainers https://fuckcloudnative.io"

WORKDIR /app

RUN apk update; \
    apk --no-cache add tini

COPY --from=builder /tmp/kubernetes/client/bin/kubectl /usr/local/bin/kubectl
COPY --from=builder /src/hugo-webhook .
COPY start.sh /app
COPY hugo-update.yaml /app

EXPOSE 80

ENTRYPOINT ["tini", "--"]
CMD ["./hugo-webhook"]