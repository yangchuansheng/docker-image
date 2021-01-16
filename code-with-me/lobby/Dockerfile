FROM debian:buster-slim
ARG DISTRIBUTION_VERSION=""
ADD lobby-server-linux-x64.tar.gz /home/lobby-server
COPY lobby_private.pem /home/lobby-server/lobby_private.pem
RUN apt-get update && apt-get install -y unzip net-tools procps && apt-get clean
WORKDIR /home/lobby-server
ENV JAVA_HOME /home/lobby-server/jbr
ENV SERVER_PORT 2093
ENV BASE_URL https://lobby.cwm.internal
ENV ENABLED_FEATURES p2p_quic,direct_tcp,ws_relay
ENV FORCE_RELAY_URI wss://relay.cwm.internal
ENV RELAYS_ECDSA_JWT_KEY_FILE /home/lobby-server/lobby_private.pem
ENV REDIS_HOST redis
ENV REDIS_PORT 6379
ENTRYPOINT ["bin/lobby-server"]