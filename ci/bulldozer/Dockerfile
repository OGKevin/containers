ARG GOLANG_VERSION=1.21@sha256:24a09375a6216764a3eda6a25490a88ac178b5fcb9511d59d0da5ebf9e496474
FROM golang:${GOLANG_VERSION} as builder

ARG VERSION=v1.17.0

WORKDIR /app

RUN git clone https://github.com/palantir/bulldozer.git --branch ${VERSION} --depth 1

WORKDIR /app/bulldozer

COPY installation-token.patch .
RUN git apply installation-token.patch

RUN CGO_ENABLED=0 go build -o /bulldozer .

FROM alpine@sha256:eece025e432126ce23f223450a0326fbebde39cdf496a85d8c016293fc851978 as certs

FROM scratch

LABEL org.opencontainers.image.source=https://github.com/OGKevin/containers

COPY --from=builder /bulldozer /bulldozer
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT ["/bulldozer"]
