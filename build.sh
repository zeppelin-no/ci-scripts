#!/bin/sh

# Builds Docker image from current directory, and tags it:
#
#    <DOCKER_TAG_NAME>:<DOCKER_SHA_TAG>
#
# The variable DOCKER_SHA_TAG should be unique, e.g. inferred from the Git SHA.

# DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(dirname "$0")

${DIR}/docker/build.sh
