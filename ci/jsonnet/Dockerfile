FROM debian:11@sha256:c141beaa9e0767774221cc82efe3a6712a1cc4f75d2699334dfd9a28a6f7357b

RUN apt update && apt install -y \
    git \
    jsonnet \
    && rm -rf /var/lib/apt/lists/* \
