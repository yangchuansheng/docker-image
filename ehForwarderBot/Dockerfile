FROM python:alpine
LABEL maintainer="ehForwarderBot Docker Maintainers https://fuckcloudnative.io"

ENV LANG C.UTF-8
ENV TZ Asia/Shanghai

RUN set -ex \
   && apk --no-cache add \
      python3-dev \
      py3-pillow \
      py3-ruamel.yaml \
      libmagic \
      ffmpeg \
      git \
      gcc \
      zlib-dev \
      jpeg-dev \
      musl-dev \
      libffi-dev \
      openssl-dev \
      libwebp-dev \
   && pip3 install ehforwarderbot efb-telegram-master efb-wechat-slave python-telegram-bot \
   && pip3 install --no-deps --force-reinstall Pillow \
   && sed -i "s/webwxnewloginpage?mod=desktop/webwxnewloginpage/g" /usr/local/lib/python3.10/site-packages/efb_wechat_slave/vendor/itchat/components/login.py \
   && mkdir -p /root/.ehforwarderbot/profiles/default/blueset.telegram /root/.ehforwarderbot/modules/

COPY config.yaml /root/.ehforwarderbot/profiles/default/

VOLUME /root/.ehforwarderbot/profiles/default/blueset.telegram

ENTRYPOINT ["ehforwarderbot"]
