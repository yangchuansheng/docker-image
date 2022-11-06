FROM okteto/golang:1.16

RUN \
  apt update;\
  curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -; \
  apt install -y zsh gcc gdb wget git nodejs make clang; \
  rm -rf /var/lib/apt/lists/*; \
  git clone https://github.com/cs50/libcs50; \
  cd libcs50 && make install
    
