ARG GOLANG_VERSION=1.21@sha256:b113af1e8b06f06a18ad41a6b331646dff587d7a4cf740f4852d16c49ed8ad73
FROM golang:${GOLANG_VERSION} as builder

ARG VERSION=v1.31.0

WORKDIR /app

RUN git clone https://github.com/palantir/policy-bot.git --branch ${VERSION} --depth 1

WORKDIR /app/policy-bot

COPY installation-token.patch .
RUN git apply installation-token.patch

RUN CGO_ENABLED=0 go build -o /policy-bot .

FROM alpine@sha256:eece025e432126ce23f223450a0326fbebde39cdf496a85d8c016293fc851978 as certs

FROM scratch

LABEL org.opencontainers.image.source=https://github.com/OGKevin/containers

COPY --from=builder /policy-bot /policy-bot
COPY --from=builder /app/policy-bot/docker/mime.types /etc/
COPY --from=builder /app/policy-bot/server/templates /templates
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT ["/policy-bot"]
