FROM ghcr.io/linuxserver/code-server:4.4.0

ARG UID=1000
ARG GID=1000

## change owner and group for /config, or else hit "error EACCES: permission denied, mkdir '/config/.config'"
RUN chown $UID:$GID -R /config

USER root

# environment settings
ENV HOME="/config"
ENV HUGO_VERSION="0.85.0"
ENV RUSTUP_HOME=/config/rustup \
    CARGO_HOME=/config/cargo \
    PATH=/config/cargo/bin:$PATH \
    RUST_VERSION=1.58.0
    
RUN \
  echo "**** install my tools ****"; \
  apt update; \
  apt install -y gcc gdb wget; \
  curl -LJO https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.deb; \
  dpkg -i hugo_extended_${HUGO_VERSION}_Linux-64bit.deb; \
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
  chmod -R a+w $RUSTUP_HOME $CARGO_HOME
  
## We have to install extensions as host UID:GID so the code-server can only identify the extensions when we start
## the container by forwarding host UID/GID later.
USER $UID:$GID
  
## Because of taking user by $UID:$GID, container can't identify the HOME(~) variable, so we need to
## declare HOME explicitely, or else hit err "info  Wrote default config file to ~/.config/code-server/config.yaml" 
RUN HOME=/config /usr/local/bin/code-server \
    --user-data-dir=/config/.local/share/code-server \
    --install-extension bungcip.better-toml \
    --install-extension CoenraadS.bracket-pair-colorizer-2 \
    --install-extension ericadamski.carbon-now-sh \
    --install-extension formulahendry.code-runner \
    --install-extension Shan.code-settings-sync \
    --install-extension adpyke.codesnap
