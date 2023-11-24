FROM node:lts@sha256:445acd9b2ef7e9de665424053bf95652e0b8995ef36500557d48faf29300170a

LABEL org.opencontainers.image.source https://github.com/ogkevin/containers

WORKDIR /app

COPY repo/ /app
RUN npm ci

ENTRYPOINT [ "node", "./build/src/bin/release-please.js" ]
