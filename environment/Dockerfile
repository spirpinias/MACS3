# hash:sha256:08302b90ec591a6ae3b4c315af814ae1ba6d7beeddca9a445c6be267831b5048
FROM registry.apps.codeocean.com/codeocean/jupyterlab:3.4.4-miniconda4.12.0-python3.9-ubuntu20.04

ARG DEBIAN_FRONTEND=noninteractive

ARG GIT_ASKPASS
ARG GIT_ACCESS_TOKEN
COPY git-askpass /

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        gcc \
        python-dev \
    && rm -rf /var/lib/apt/lists/*

RUN conda install -y \
        python3-dev \
    && conda clean -ya

RUN pip install -U --no-cache-dir \
    macs3 \
    pandas

COPY postInstall /
RUN /postInstall
