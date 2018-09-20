#!/bin/sh

# Deploy a Docker image to Kubernetes by pushing it to a registry and applying
# the Kubernetes configuration. This assumes Kubernetes config is in the form
# of '*.yml' files placed in the `./k8s` folder.
#
# Takes two ordered arguments:
#   - namespace   The kubernetes namespace to use.
#   - tag         The docker tag to use (optional). If no tag is specified,
#                 then DOCKER_SHA_TAG is used.
#
# Assumes there's a Docker image <DOCKER_TAG_NAME>:<DOCKER_SHA_TAG> available.

echo "DEPRECTATED use push.sh and apply.sh instead"

K8S_NAMESPACE=$1
DOCKER_TAG=$2

DIR=$(dirname "$0")

echo "Deploying with tag ${DOCKER_TAG} to namespace ${K8S_NAMESPACE}"

echo "Pushing..."
if ${DIR}/docker/push.sh ${DOCKER_TAG} ; then
  echo "Push done, deploying..."
  if ${DIR}/k8s/apply.sh ${K8S_NAMESPACE} ${DOCKER_TAG} ; then
    echo "Deploy complete."
  else
    echo "Deploy failed!"
    exit 1
  fi
else
  echo "Push failed!"
  exit 1
fi
