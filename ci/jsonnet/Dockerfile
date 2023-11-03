FROM debian:11@sha256:a4aa0519fbd45786048bbc4daa7092fec803d22463f1cb6c4e7762dcb6a10cf0

RUN apt update && apt install -y \
    git \
    jsonnet \
    && rm -rf /var/lib/apt/lists/* \
