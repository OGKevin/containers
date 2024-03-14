FROM golang:1.22@sha256:0b55ab82ac2a54a6f8f85ec8b943b9e470c39e32c109b766bbc1b801f3fa8d3b as builder

RUN apt-get update && apt-get install -y \
    git \
    make \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /

RUN git clone https://github.com/getsops/sops.git --depth 1 --branch v3.7.1

WORKDIR /sops

RUN CGO_ENABLED=0 go build -o /out/sops go.mozilla.org/sops/v3/cmd/sops

FROM gcr.io/distroless/static-debian11:debug-nonroot@sha256:cdb2034c38b2f2bd0a99f08191a44831a04220c81aab97b2397d2ecf1082db5f

COPY --from=builder /out/sops /bin/sops

ENTRYPOINT ["/busybox/sh"]