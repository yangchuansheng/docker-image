FROM php:7.3-fpm 

LABEL maintainer="disqus-php-api Docker Maintainers https://fuckcloudnative.io"

RUN set -x \
    && apt update \
    && apt install --no-install-recommends --no-install-suggests -y git \
    && git clone https://github.com/fooleap/disqus-php-api \
    && cp -r ./disqus-php-api/api/* /var/www/html/ \
    && apt remove --purge --auto-remove -y git && rm -rf /var/lib/apt/lists/* /etc/apt/sources.list.d/nginx.list \
    \
    && if [ -n "$tempDir" ]; then \
        apt-get purge -y --auto-remove \
        && rm -rf "$tempDir" /etc/apt/sources.list.d/temp.list; \
    fi
