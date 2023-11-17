FROM golang:1.21@sha256:57bf74a970b68b10fe005f17f550554406d9b696d10b29f1a4bdc8cae37fd063 as builder

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