ARG GOLANG_VERSION=1.22@sha256:0b55ab82ac2a54a6f8f85ec8b943b9e470c39e32c109b766bbc1b801f3fa8d3b
FROM golang:${GOLANG_VERSION} as builder

ARG VERSION=v1.17.0

WORKDIR /app

RUN git clone https://github.com/palantir/bulldozer.git --branch ${VERSION} --depth 1

WORKDIR /app/bulldozer

COPY installation-token.patch .
RUN git apply installation-token.patch

RUN CGO_ENABLED=0 go build -o /bulldozer .

FROM alpine@sha256:34871e7290500828b39e22294660bee86d966bc0017544e848dd9a255cdf59e0 as certs

FROM scratch

LABEL org.opencontainers.image.source=https://github.com/OGKevin/containers

COPY --from=builder /bulldozer /bulldozer
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT ["/bulldozer"]
