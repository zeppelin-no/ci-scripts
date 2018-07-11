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

K8S_NAMESPACE=$1
DOCKER_TAG=$2

DIR=$(dirname "$0")

${DIR}/k8s/ensure-kubectl.sh

${DIR}/ecr/authenticate.sh

echo "Deploying with tag ${DOCKER_TAG} to namespace ${K8S_NAMESPACE}"
${DIR}/docker/push.sh ${DOCKER_TAG}

${DIR}/k8s/authenticate.sh ${K8S_NAMESPACE}
${DIR}/k8s/apply.sh ${K8S_NAMESPACE} ${DOCKER_TAG}

echo "Deploy complete."
