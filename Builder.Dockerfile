FROM --platform=linux/arm64 debian:bullseye-slim

RUN apt update -y
RUN apt install -y git python3 make g++ ffmpeg curl
RUN curl -SLO https://deb.nodesource.com/nsolid_setup_deb.sh
RUN chmod 500 nsolid_setup_deb.sh
RUN ./nsolid_setup_deb.sh 21
RUN apt install -y nodejs
RUN npm i -g npm pnpm typescript vite @swc/cli typeorm
