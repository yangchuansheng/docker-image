FROM ghcr.io/linuxserver/baseimage-ubuntu:bionic

# set version label
ARG BUILD_DATE
ARG VERSION
ARG CODE_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aptalca"

# environment settings
ENV HOME="/config"
ENV HUGO_VERSION="0.85.0"
ENV RUSTUP_HOME=/config/rustup \
    CARGO_HOME=/config/cargo \
    PATH=/config/cargo/bin:$PATH \
    RUST_VERSION=1.58.0

RUN \
  echo "**** install node repo ****" && \
  apt-get update && \
  apt-get install -y \
    gnupg && \
  curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
  echo 'deb https://deb.nodesource.com/node_14.x bionic main' \
    > /etc/apt/sources.list.d/nodesource.list && \
  curl -s https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo 'deb https://dl.yarnpkg.com/debian/ stable main' \
    > /etc/apt/sources.list.d/yarn.list && \
  echo "**** install my tools ****" && \
  apt-get install -y gcc gdb && \
  curl -LJO https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.deb && \
  dpkg -i hugo_extended_${HUGO_VERSION}_Linux-64bit.deb && \
  dpkgArch="$(dpkg --print-architecture)"; \
  case "${dpkgArch##*-}" in \
      amd64) rustArch='x86_64-unknown-linux-gnu'; rustupSha256='3dc5ef50861ee18657f9db2eeb7392f9c2a6c95c90ab41e45ab4ca71476b4338' ;; \
      armhf) rustArch='armv7-unknown-linux-gnueabihf'; rustupSha256='67777ac3bc17277102f2ed73fd5f14c51f4ca5963adadf7f174adf4ebc38747b' ;; \
      arm64) rustArch='aarch64-unknown-linux-gnu'; rustupSha256='32a1532f7cef072a667bac53f1a5542c99666c4071af0c9549795bbdb2069ec1' ;; \
      i386) rustArch='i686-unknown-linux-gnu'; rustupSha256='e50d1deb99048bc5782a0200aa33e4eea70747d49dffdc9d06812fd22a372515' ;; \
      *) echo >&2 "unsupported architecture: ${dpkgArch}"; exit 1 ;; \
  esac; \
  url="https://static.rust-lang.org/rustup/archive/1.24.3/${rustArch}/rustup-init"; \
  wget "$url"; \
  echo "${rustupSha256} *rustup-init" | sha256sum -c -; \
  chmod +x rustup-init; \
  ./rustup-init -y --no-modify-path --profile minimal --default-toolchain $RUST_VERSION --default-host ${rustArch}; \
  rm rustup-init; \
  chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
  echo "**** install build dependencies ****" && \
  apt-get update && \
  apt-get install -y \
    build-essential \
    libx11-dev \
    libxkbfile-dev \
    libsecret-1-dev \
    pkg-config && \
  echo "**** install runtime dependencies ****" && \
  apt-get install -y \
    git \
    jq \
    nano \
    net-tools \
    nodejs \
    sudo \
    yarn && \
  echo "**** install code-server ****" && \
  if [ -z ${CODE_RELEASE+x} ]; then \
    CODE_RELEASE=$(curl -sX GET https://registry.yarnpkg.com/code-server \
    | jq -r '."dist-tags".latest' | sed 's|^|v|'); \
  fi && \
  CODE_VERSION=$(echo "$CODE_RELEASE" | awk '{print substr($1,2); }') && \
  yarn config set network-timeout 600000 -g && \
  yarn --production --verbose --frozen-lockfile global add code-server@"$CODE_VERSION" font-spider-plus && \
  yarn cache clean && \
  echo "**** clean up ****" && \
  apt-get purge --auto-remove -y \
    build-essential \
    libx11-dev \
    libxkbfile-dev \
    libsecret-1-dev \
    pkg-config && \
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 8443
