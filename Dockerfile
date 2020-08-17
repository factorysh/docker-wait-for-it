FROM bearstech/debian:buster

RUN set -eux \
    &&  apt-get update \
    &&  apt-get install  -y --no-install-recommends \
                  wait-for-it \
    &&  apt-get clean \
    &&  rm -rf /var/lib/apt/lists/* \
    &&  useradd --home-dir /wait --create-home --shell /bin/bash wait

WORKDIR /wait
USER wait

# generated labels

ARG GIT_VERSION
ARG GIT_DATE
ARG BUILD_DATE

LABEL \
    com.bearstech.image.revision_date=${GIT_DATE} \
    org.opencontainers.image.authors=Bearstech \
    org.opencontainers.image.revision=${GIT_VERSION} \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.url=https://github.com/factorysh/docker-wait-for-it \
    org.opencontainers.image.source=https://github.com/factorysh/docker-wait-for-it/blob/${GIT_VERSION}/Dockerfile

