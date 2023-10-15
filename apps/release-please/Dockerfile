FROM node:lts@sha256:cd7fa8f136023f7500490e410ba70dd3982ccca21805264f2a260a3a97be7376

LABEL org.opencontainers.image.source https://github.com/ogkevin/containers

WORKDIR /app

COPY repo/ /app
RUN npm ci

ENTRYPOINT [ "node", "./build/src/bin/release-please.js" ]

