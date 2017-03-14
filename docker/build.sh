#!/bin/bash

# Load cache if it exists
if [[ -e ~/docker/image.tar ]]; then docker load -i ~/docker/image.tar; fi

export DOCKER_SHA_TAG=${CIRCLE_SHA1:0:7}

docker build --rm=false -t ${DOCKER_TAG_NAME} .
docker tag -f ${DOCKER_TAG_NAME}:latest ${DOCKER_TAG_NAME}:${DOCKER_SHA_TAG}

# Store cache
mkdir -p ~/docker; docker save ${DOCKER_TAG_NAME} > ~/docker/image.tar
