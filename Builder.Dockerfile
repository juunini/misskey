FROM --platform=linux/arm64 debian:bullseye-slim

RUN apt update -y
RUN apt install -y git python3 make g++ ffmpeg curl
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash -
RUN apt install -y nodejs
RUN npm i -g npm pnpm typescript vite @swc/cli typeorm
