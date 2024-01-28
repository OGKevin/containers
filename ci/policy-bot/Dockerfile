ARG GOLANG_VERSION=1.21@sha256:9baee0edab4139ae9b108fffabb8e2e98a67f0b259fd25283c2a084bd74fea0d
FROM golang:${GOLANG_VERSION} as builder

ARG VERSION=v1.31.0

WORKDIR /app

RUN git clone https://github.com/palantir/policy-bot.git --branch ${VERSION} --depth 1

WORKDIR /app/policy-bot

COPY installation-token.patch .
RUN git apply installation-token.patch

RUN CGO_ENABLED=0 go build -o /policy-bot .

FROM alpine@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b as certs

FROM scratch

LABEL org.opencontainers.image.source=https://github.com/OGKevin/containers

COPY --from=builder /policy-bot /policy-bot
COPY --from=builder /app/policy-bot/docker/mime.types /etc/
COPY --from=builder /app/policy-bot/server/templates /templates
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT ["/policy-bot"]
