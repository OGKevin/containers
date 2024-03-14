ARG GOLANG_VERSION=1.22@sha256:0b55ab82ac2a54a6f8f85ec8b943b9e470c39e32c109b766bbc1b801f3fa8d3b
FROM golang:${GOLANG_VERSION} as builder

ARG VERSION=v0.1.0-alpha.27
ARG VERSION_PKG="github.com/siderolabs/conform/internal/version"

WORKDIR /app

RUN git clone https://github.com/siderolabs/conform.git --branch ${VERSION} --depth 1

WORKDIR /app/conform

RUN go mod vendor && go mod verify

RUN CGO_ENABLED=0 go build -ldflags "-extldflags=-static -s -w -X ${VERSION_PKG}.Name=conform -X ${VERSION_PKG}.SHA=${SHA} -X ${VERSION_PKG}.Tag=${VERSION}" -o /conform ./cmd/conform/

FROM scratch

LABEL org.opencontainers.image.source=https://github.com/OGKevin/containers

COPY --from=builder /conform /conform

ENTRYPOINT ["/conform"]
