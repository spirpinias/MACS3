# hash:sha256:1055d6b30c1fb3923b42b14d611cffc9d2b6cecebec55dce36d510bd4591f33b
FROM registry.apps.codeocean.com/codeocean/jupyterlab:3.4.4-miniconda4.12.0-python3.9-ubuntu20.04

ARG DEBIAN_FRONTEND=noninteractive

ARG GIT_ASKPASS
ARG GIT_ACCESS_TOKEN
COPY git-askpass /

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential=12.8ubuntu1.1 \
        gcc=4:9.3.0-1ubuntu2 \
        python-dev \
        python3-dev=3.8.2-0ubuntu2 \
    && rm -rf /var/lib/apt/lists/*

RUN pip install -U --no-cache-dir \
    macs3==3.0.0b1 \
    pandas==1.5.2

COPY postInstall /
RUN /postInstall
