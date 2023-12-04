FROM debian:11@sha256:ab2b95aa8d7d6d54866b92c322cf0693933c1ae8038652f24ddfda1d1763a45a

RUN apt update && apt install -y \
    git \
    jsonnet \
    && rm -rf /var/lib/apt/lists/* \
