FROM python:3.9-slim

LABEL maintainer="lotus-farcaster Maintainers https://fuckcloudnative.io"

# Allow environment variables to be passed as build time arguments
ARG FREQUENCY=50

# Set environment variables to build arguments
ENV FREQUENCY=$FREQUENCY

# RUN pip3 install py-multibase toml aiohttp
RUN pip3 install toml; \
    pip3 install aiohttp; \
    pip3 install py-multibase

# Copy lotus-farcaster program and shell script that invokes it to the container
COPY lotus-exporter-farcaster.py /usr/local/bin/
COPY docker_run_script.sh /usr/local/bin/

# Create /data which will hold the output of the lotus-farcaster
RUN mkdir /data

# Run the container on an unprivileged user XXX not implemented yet // need rights to store files to prometheus folder
#RUN useradd -r -u 424242 -U farcaster
#USER farcaster


CMD ["/usr/local/bin/docker_run_script.sh"]