# arguments
ARG VERSION="master"
# Branch to check out
ARG CHECKOUT_BRANCH="master"

FROM node:current-alpine AS build

#environment variables
ENV PROJECT_NAME="headscale-ui"
# URL for the github/git location
ENV PROJECT_URL="https://github.com/gurucomputing/headscale-ui"

# Set the staging environment
WORKDIR /staging/scripts
WORKDIR /staging
RUN chown 1000:1000 /staging

# Copy across the scripts folder
COPY scripts/* ./scripts/

# Set permissions for all scripts. We do not want normal users to have write
# access to the scripts
RUN chown -R 0:0 scripts
RUN chmod -R 755 scripts

# Build the image. This build runs as root
RUN /staging/scripts/1-image-build.sh

#####
## Second Image
#####

FROM nginx:latest

LABEL org.opencontainers.image.source https://github.com/yangchuansheng/docker-image

COPY templates /etc/nginx/templates
COPY --from=build /staging/${PROJECT_NAME}/build /usr/share/nginx/html/web
