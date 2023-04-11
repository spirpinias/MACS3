# hash:sha256:ed0dbb5385f57117fc09568bc517d43a1a75fdc5f57653f87e90891fbe315761
FROM registry.apps.codeocean.com/codeocean/mambaforge3:22.11.1-4-ubuntu22.04

ARG DEBIAN_FRONTEND=noninteractive

ARG GIT_ASKPASS
ARG GIT_ACCESS_TOKEN
COPY git-askpass /

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        gcc \
        git \
        python-dev \
        python3-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install -U --no-cache-dir \
    macs3 \
    pandas

COPY postInstall /
RUN /postInstall
