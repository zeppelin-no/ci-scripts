#!/bin/bash

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

source "${BASH_SOURCE%/*}/docker/push.sh" $2
source "${BASH_SOURCE%/*}/k8s/apply.sh" $1 $2
