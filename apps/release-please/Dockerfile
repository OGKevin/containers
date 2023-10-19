FROM node:lts@sha256:a6385a6bb2fdcb7c48fc871e35e32af8daaa82c518900be49b76d10c005864c2

LABEL org.opencontainers.image.source https://github.com/ogkevin/containers

WORKDIR /app

COPY repo/ /app
RUN npm ci

ENTRYPOINT [ "node", "./build/src/bin/release-please.js" ]

