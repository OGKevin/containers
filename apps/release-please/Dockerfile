FROM node:lts@sha256:5f21943fe97b24ae1740da6d7b9c56ac43fe3495acb47c1b232b0a352b02a25c

LABEL org.opencontainers.image.source https://github.com/ogkevin/containers

WORKDIR /app

COPY repo/ /app
RUN npm ci

ENTRYPOINT [ "node", "./build/src/bin/release-please.js" ]
