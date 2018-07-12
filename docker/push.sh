#!/bin/sh
echo "DEBUG --- docker push START  ---"
DOCKER_SHA_TAG="$(echo $CIRCLE_SHA1 | cut -c -7)"

VERSION=${DOCKER_SHA_TAG}

if [ ! -z "$1" ]; then
  VERSION="$1"
  docker tag ${DOCKER_TAG_NAME}:${DOCKER_SHA_TAG} ${DOCKER_TAG_NAME}:${VERSION}
fi

docker tag ${DOCKER_TAG_NAME}:${VERSION} ${DOCKER_REGISTRY}/${DOCKER_TAG_NAME}:${VERSION}

echo "Pushing Docker image to registry with tag ${VERSION}"

docker push ${DOCKER_REGISTRY}/${DOCKER_TAG_NAME}:${VERSION}
