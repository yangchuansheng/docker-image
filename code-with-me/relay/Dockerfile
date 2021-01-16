FROM alpine:latest
ARG DISTRIBUTION_VERSION=""
COPY ws-relayd /ws-relayd
RUN chmod +x /ws-relayd
COPY relay_public.pem /relay_public.pem
CMD /ws-relayd -addr relay:3274 -jwt-key-type ecdsa -jwt-key-file /relay_public.pem