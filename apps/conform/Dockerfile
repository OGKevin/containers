ARG GOLANG_VERSION=1.21@sha256:24a09375a6216764a3eda6a25490a88ac178b5fcb9511d59d0da5ebf9e496474
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
