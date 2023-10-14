ARG GOLANG_VERSION=1.21
FROM golang:${GOLANG_VERSION} as builder

ARG VERSION=v1.17.0

WORKDIR /app

RUN git clone https://github.com/palantir/bulldozer.git --branch ${VERSION} --depth 1

WORKDIR /app/bulldozer

COPY installation-token.patch .
RUN git apply installation-token.patch

RUN CGO_ENABLED=0 go build -o /bulldozer .

FROM alpine as certs

FROM scratch

LABEL org.opencontainers.image.source=https://github.com/OGKevin/containers

COPY --from=builder /bulldozer /bulldozer
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT ["/bulldozer"]
