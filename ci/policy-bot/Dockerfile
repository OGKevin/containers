ARG GOLANG_VERSION=1.21@sha256:856073656d1a517517792e6cdd2f7a5ef080d3ca2dff33e518c8412f140fdd2d
FROM golang:${GOLANG_VERSION} as builder

ARG VERSION=v1.31.0

WORKDIR /app

RUN git clone https://github.com/palantir/policy-bot.git --branch ${VERSION} --depth 1

WORKDIR /app/policy-bot

COPY installation-token.patch .
RUN git apply installation-token.patch

RUN CGO_ENABLED=0 go build -o /policy-bot .

FROM alpine@sha256:34871e7290500828b39e22294660bee86d966bc0017544e848dd9a255cdf59e0 as certs

FROM scratch

LABEL org.opencontainers.image.source=https://github.com/OGKevin/containers

COPY --from=builder /policy-bot /policy-bot
COPY --from=builder /app/policy-bot/docker/mime.types /etc/
COPY --from=builder /app/policy-bot/server/templates /templates
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT ["/policy-bot"]
