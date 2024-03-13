FROM debian:11@sha256:5a87974e73c64b3fb161d444a84bdd47c0e6b6058eacaeea64342e7cbce1f04d

RUN apt update && apt install -y \
    git \
    jsonnet \
    && rm -rf /var/lib/apt/lists/* \
