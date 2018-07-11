#!/bin/sh


DOCKER_SHA_TAG="$(echo $CIRCLE_SHA1 | cut -c -7)"

if [ -z "${DOCKER_SHA_TAG}" ]; then
  echo "ERROR the DOCKER_SHA_TAG is empty: '${DOCKER_SHA_TAG}' based on '$CIRCLE_SHA1'"
  exit 1
else
  echo "OK the DOCKER_SHA_TAG is defined: '${DOCKER_SHA_TAG}' based on '$CIRCLE_SHA1'"
fi

# Load cache if it exists
# @NOTE: Trying to use Docker cache with CircleCI 1.0 seems to do more harm
# than good. Disabling for now.
# if [[ -e ~/docker/image.tar ]]; then docker load -i ~/docker/image.tar; fi

echo "Building ${DOCKER_TAG_NAME}"
docker build --rm=false -t ${DOCKER_TAG_NAME} .
echo "Create tags ${DOCKER_TAG_NAME}:latest ${DOCKER_TAG_NAME}:${DOCKER_SHA_TAG}"
docker tag ${DOCKER_TAG_NAME}:latest ${DOCKER_TAG_NAME}:${DOCKER_SHA_TAG}

# Store cache
# mkdir -p ~/docker; docker save ${DOCKER_TAG_NAME} > ~/docker/image.tar
