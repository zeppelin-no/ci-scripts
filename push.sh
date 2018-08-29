#!/bin/sh

# Push a Docker image to a registry
#
# Takes two ordered arguments:
#   - tag         The docker tag to use (optional). If no tag is specified,
#                 then DOCKER_SHA_TAG is used.
#
# Assumes there's a Docker image <DOCKER_TAG_NAME>:<DOCKER_SHA_TAG> available.

DOCKER_TAG=$1

DIR=$(dirname "$0")

echo "Pushing tag ${DOCKER_TAG}"

if ${DIR}/docker/push.sh ${DOCKER_TAG} ; then
  echo "Push done"
else
  echo "Push failed!"
  exit 1
fi
