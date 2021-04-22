FROM alpine AS builder
LABEL maintainer="vscode Maintainers https://fuckcloudnative.io"

WORKDIR /vscode

RUN apk update; \
    apk add curl wget

RUN curl -sOL https://github.com/krallin/tini/releases/download/v0.19.0/tini; \
    chmod +x tini

RUN wget -O vscode-web.tar.gz https://update.code.visualstudio.com/latest/server-linux-x64-web/stable; \
    tar xzvf vscode-web.tar.gz

FROM alpine
LABEL maintainer="vscode Maintainers https://fuckcloudnative.io"

COPY --from=builder /vscode/tini /usr/local/bin/tini
COPY --from=builder /vscode/vscode-server-linux-x64-web /vscode-server-linux-x64-web

WORKDIR /vscode-server-linux-x64-web

ENTRYPOINT ["tini", "--"]

CMD ["./server.sh"]
