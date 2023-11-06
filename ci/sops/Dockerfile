FROM golang:1.21 as builder

RUN apt-get update && apt-get install -y \
    git \
    make \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /

RUN git clone https://github.com/getsops/sops.git --depth 1 --branch v3.7.1

WORKDIR /sops

RUN CGO_ENABLED=0 go build -o /out/sops go.mozilla.org/sops/v3/cmd/sops

FROM gcr.io/distroless/static-debian11:debug-nonroot

COPY --from=builder /out/sops /bin/sops

ENTRYPOINT ["/busybox/sh"]