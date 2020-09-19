FROM alpine
LABEL maintainer="octant Docker Maintainers https://fuckcloudnative.io"

ARG OCTANT_VERSION=0.15.0

RUN wget -O /tmp/octant.tar.gz "https://github.com/vmware-tanzu/octant/releases/download/v${OCTANT_VERSION}/octant_${OCTANT_VERSION}_Linux-64bit.tar.gz" && \
    tar xf /tmp/octant.tar.gz -C /tmp && \
    mv -v /tmp/octant_0.15.0_Linux-64bit/octant /usr/local/bin/ && \
    rm -rf /tmp/* /var/cache/apk/*

# octant listen port
EXPOSE 80

ENTRYPOINT [ "/usr/local/bin/octant", "--kubeconfig", "/root/.kube/config" ]
CMD [ "--listener-addr", "0.0.0.0:80" "--disable-open-browser" ]