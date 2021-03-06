FROM alpine AS builder
LABEL maintainer="hugo-webhook Maintainers https://fuckcloudnative.io"

# config
ENV HUGO_VERSION=0.75.1

RUN apk update; \
    apk --no-cache add curl; \
    wget -O - https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz | tar -xz -C /tmp; \
    curl -sL https://github.com/krallin/tini/releases/download/v0.19.0/tini -o /tmp/tini; \
    chmod +x /tmp/tini;

FROM node:current-alpine
LABEL maintainer="hugo-webhook Maintainers https://fuckcloudnative.io"

WORKDIR /app

COPY --from=builder /tmp/hugo /usr/local/bin/hugo
COPY --from=builder /tmp/tini /usr/local/bin/tini
COPY deploy.sh /app
COPY webhook.js /app

EXPOSE 80

ENTRYPOINT ["tini", "--"]
CMD ["node", "webhook.js"]