ARG GOLANG_VERSION=1.20
ARG DEBIAN_VERSION=10

FROM golang:${GOLANG_VERSION} as builder

ARG VERSION=v0.31.0

WORKDIR /app

RUN git clone https://github.com/tektoncd/cli.git --branch ${VERSION} --depth 1

WORKDIR /app/cli

RUN go mod vendor && go mod verify

RUN make RELEASE_VERSION=${VERSION} bin/tkn

FROM debian:${DEBIAN_VERSION} as tkn
COPY --from=builder /app/cli/bin/tkn /usr/bin
