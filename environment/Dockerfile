# hash:sha256:66bb9dc4a463eb15619af94f8ede7d4fb38572b16485ce87b38be61c799f22ab
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
        python3-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install -U --no-cache-dir \
    macs3 \
    pandas

COPY postInstall /
RUN /postInstall
