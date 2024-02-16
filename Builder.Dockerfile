FROM --platform=linux/arm64 debian:bullseye-slim

RUN apt update -y &&\
  apt install -y git python3 make g++ ffmpeg curl libjemalloc-dev libjemalloc2 tini &&\
  ln -s /usr/lib/$(uname -m)-linux-gnu/libjemalloc.so.2 /usr/local/lib/libjemalloc.so &&\
  curl -SLO https://deb.nodesource.com/nsolid_setup_deb.sh &&\
  chmod 500 nsolid_setup_deb.sh &&\
  ./nsolid_setup_deb.sh 21 &&\
  apt install -y nodejs &&\
  npm i -g npm pnpm typescript vite @swc/cli typeorm &&\
  apt clean &&\
  rm -rf /var/lib/apt/lists
