# hash:sha256:153d94d7db2798eae4db7e4f957edaebb7a05477d6b743302e0e7ea63b9a2221
FROM registry.apps.codeocean.com/codeocean/mambaforge3:22.11.1-4-ubuntu22.04

ARG DEBIAN_FRONTEND=noninteractive

ARG GIT_ASKPASS
ARG GIT_ACCESS_TOKEN
COPY git-askpass /

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential=12.9ubuntu3 \
        ca-certificates=20211016ubuntu0.22.04.1 \
        gcc=4:11.2.0-1ubuntu1 \
        git=1:2.34.1-1ubuntu1.8 \
        python2-dev=2.7.18-3 \
        python3-dev=3.10.6-1~22.04 \
    && rm -rf /var/lib/apt/lists/*

RUN pip install -U --no-cache-dir \
    macs3==3.0.0b1 \
    pandas==2.0.0

COPY postInstall /
RUN /postInstall
