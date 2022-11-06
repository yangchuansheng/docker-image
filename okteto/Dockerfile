FROM okteto/golang:1.16

RUN \
  apt update;\
  curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -; \
  apt install -y zsh gcc gdb wget git nodejs make clang python3-pip; \
  rm -rf /var/lib/apt/lists/*; \
  pip3 install help50; \
  pip3 install style50; \
  git clone https://github.com/cs50/libcs50; \
  cd libcs50 && make install
  
RUN chsh -s /usr/bin/zsh
