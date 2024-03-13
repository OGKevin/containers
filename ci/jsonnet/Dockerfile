FROM debian:12@sha256:e97ee92bf1e11a2de654e9f3da827d8dce32b54e0490ac83bfc65c8706568116

RUN apt update && apt install -y \
    git \
    jsonnet \
    && rm -rf /var/lib/apt/lists/* \
