FROM golang:1.21@sha256:9baee0edab4139ae9b108fffabb8e2e98a67f0b259fd25283c2a084bd74fea0d as builder

RUN apt-get update && apt-get install -y \
    git \
    make \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /

RUN git clone https://github.com/getsops/sops.git --depth 1 --branch v3.7.1

WORKDIR /sops

RUN CGO_ENABLED=0 go build -o /out/sops go.mozilla.org/sops/v3/cmd/sops

FROM gcr.io/distroless/static-debian11:debug-nonroot@sha256:c7c26a49568781eb04040f48c305b676f290dbaa9112b2f9de02c8df57a881b6

COPY --from=builder /out/sops /bin/sops

ENTRYPOINT ["/busybox/sh"]