#!/bin/bash

# Load cache if it exists
# @NOTE: Trying to use Docker cache with CircleCI 1.0 seems to do more harm
# than good. Disabling for now.
# if [[ -e ~/docker/image.tar ]]; then docker load -i ~/docker/image.tar; fi

docker build -t ${DOCKER_TAG_NAME} .  # add --rm=false when using docker cache
docker tag -f ${DOCKER_TAG_NAME}:latest ${DOCKER_TAG_NAME}:${DOCKER_SHA_TAG}

# Store cache
# mkdir -p ~/docker; docker save ${DOCKER_TAG_NAME} > ~/docker/image.tar
