FROM alpine AS builder
LABEL maintainer="hugo-webhook Maintainers https://fuckcloudnative.io"

# config
ENV KUBECTL_VERSION=1.19.5

RUN wget -O - https://dl.k8s.io/v${KUBECTL_VERSION}/kubernetes-client-linux-amd64.tar.gz | tar -xz -C /tmp

FROM node:current-alpine
LABEL maintainer="hugo-webhook Maintainers https://fuckcloudnative.io"

WORKDIR /app

RUN apk update; \
    apk --no-cache add tini; \
    cd /app; \
    npm i -S github-webhook-handler

COPY --from=builder /tmp/kubernetes/client/bin/kubectl /usr/local/bin/kubectl
COPY start.sh /app
COPY webhook.js /app
COPY hugo-update.yaml /app

EXPOSE 80

ENTRYPOINT ["tini", "--"]
CMD ["node", "webhook.js"]