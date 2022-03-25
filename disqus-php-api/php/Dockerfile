FROM php:7.4.11-fpm

LABEL org.opencontainers.image.source https://github.com/yangchuansheng/docker-image
LABEL maintainer="disqus-php-api Docker Maintainers https://fuckcloudnative.io"

RUN set -x; \
    apt update; \
    apt install --no-install-recommends --no-install-suggests -y git; \
    cd /root; \
    git clone https://github.com/fooleap/disqus-php-api; \
    cp -r ./disqus-php-api/api/* /var/www/html/; \
    sed -i "s#cn.gravatar.com#gravatar.fuckcloudnative.io#g" $(egrep -rl "cn.gravatar.com" /var/www/html/); \
    sed -i "s#a.disquscdn.com/images/noavatar92.png#jsdelivr.fuckcloudnative.io/gh/yangchuansheng/imghosting/img/20200621114024.png#g" $(egrep -rl "a.disquscdn.com" /var/www/html/); \
    sed -i "s#github.githubassets.com/images/icons/emoji/unicode#jsdelivr.fuckcloudnative.io/gh/yangchuansheng/imghosting/emoji#g" $(egrep -rl "github.githubassets.com" /var/www/html/); \
    sed -i "s#'PUBLIC_KEY', ''#'PUBLIC_KEY', getenv('PUBLIC_KEY')#g" /var/www/html/config.php; \
    sed -i "s#'SECRET_KEY', ''#'SECRET_KEY', getenv('SECRET_KEY')#g" /var/www/html/config.php; \
    sed -i "s#'DISQUS_USERNAME', ''#'DISQUS_USERNAME', getenv('USERNAME')#g" /var/www/html/config.php; \
    sed -i "s#'DISQUS_EMAIL', ''#'DISQUS_EMAIL', getenv('EMAIL')#g" /var/www/html/config.php; \
    sed -i "s#'DISQUS_PASSWORD', ''#'DISQUS_PASSWORD', getenv('PASSWD')#g" /var/www/html/config.php; \
    sed -i "s#'DISQUS_WEBSITE', ''#'DISQUS_WEBSITE', getenv('WEBSITE')#g" /var/www/html/config.php; \
    sed -i "s#'DISQUS_SHORTNAME', ''#'DISQUS_SHORTNAME', getenv('SHORTNAME')#g" /var/www/html/config.php; \
    echo "env[PUBLIC_KEY] = \$PUBLIC_KEY" >> /usr/local/etc/php-fpm.d/www.conf; \
    echo "env[SECRET_KEY] = \$SECRET_KEY" >> /usr/local/etc/php-fpm.d/www.conf; \
    echo "env[DISQUS_USERNAME] = \$DISQUS_USERNAME" >> /usr/local/etc/php-fpm.d/www.conf; \
    echo "env[DISQUS_EMAIL] = \$DISQUS_EMAIL" >> /usr/local/etc/php-fpm.d/www.conf; \
    echo "env[DISQUS_PASSWORD] = \$DISQUS_PASSWORD" >> /usr/local/etc/php-fpm.d/www.conf; \
    echo "env[DISQUS_WEBSITE] = \$DISQUS_WEBSITE" >> /usr/local/etc/php-fpm.d/www.conf; \
    echo "env[DISQUS_SHORTNAME] = \$DISQUS_SHORTNAME" >> /usr/local/etc/php-fpm.d/www.conf; \
    apt remove --purge --auto-remove -y git && rm -rf /var/lib/apt/lists/* /etc/apt/sources.list.d/nginx.list; \
    \
    if [ -n "$tempDir" ]; then \
        apt-get purge -y --auto-remove; \
        rm -rf "$tempDir" /etc/apt/sources.list.d/temp.list; \
    fi
