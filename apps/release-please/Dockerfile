FROM node:lts@sha256:62efd17e997bc843aefa4c003ed84f43dfac83fa6228c57c898482e50a02e45c

LABEL org.opencontainers.image.source https://github.com/ogkevin/containers

WORKDIR /app

COPY repo/ /app
RUN npm ci

ENTRYPOINT [ "node", "./build/src/bin/release-please.js" ]
