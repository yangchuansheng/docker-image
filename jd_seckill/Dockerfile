FROM python:3.8-slim-buster

LABEL MAINTAINER="@weidonggg"

ENV GIT_BRANCH master
ENV TIMEZONE Asia/Shanghai

COPY docker-python-entrypoint /usr/local/bin/
COPY qrcode /usr/local/bin/

RUN set -ex; \
    ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
      && echo $TIMEZONE > /etc/timezone; \
      \
      # install qrcode view tools.
      apt-get update \
        && apt-get install -y --no-install-recommends \
                   git qrencode zbar-tools \
                   libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
                   libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
                   libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 \
                   libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
                   libnss3; \
      \
      # clone jd seckill code.
      git clone -b $GIT_BRANCH https://github.com/huanghyw/jd_seckill.git /app; \
      cd /app \
        && rm -rf .git; \
      pip install -r requirements.txt; \
      \
      # init Chromium Browser
      python -c "import asyncio;\
                from pyppeteer import launch;\
                asyncio.get_event_loop()\
                    .run_until_complete(launch(args=[\"--no-sandbox\", \"--disable-setuid-sandbox\"]))"; \
      \
      chmod +x /usr/local/bin/docker-python-entrypoint; \
      chmod +x /usr/local/bin/qrcode; \
      \
      # clean apt cache.
      apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
      rm -rf /var/lib/apt/lists/*


WORKDIR /app

ENTRYPOINT ["docker-python-entrypoint"]

CMD ["seckill"]
      
