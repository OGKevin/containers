ARG GOLANG_VERSION=1.21@sha256:9baee0edab4139ae9b108fffabb8e2e98a67f0b259fd25283c2a084bd74fea0d
FROM golang:${GOLANG_VERSION} as builder

ARG VERSION=v1.17.0

WORKDIR /app

RUN git clone https://github.com/palantir/bulldozer.git --branch ${VERSION} --depth 1

WORKDIR /app/bulldozer

COPY installation-token.patch .
RUN git apply installation-token.patch

RUN CGO_ENABLED=0 go build -o /bulldozer .

FROM alpine@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b as certs

FROM scratch

LABEL org.opencontainers.image.source=https://github.com/OGKevin/containers

COPY --from=builder /bulldozer /bulldozer
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT ["/bulldozer"]
