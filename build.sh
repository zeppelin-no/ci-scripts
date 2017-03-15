#!/bin/bash

# Builds Docker image from current directory, and tags it:
#
#    <DOCKER_TAG_NAME>:<DOCKER_SHA_TAG>
#
# The variable DOCKER_SHA_TAG should be unique, e.g. inferred from the Git SHA.

source "${BASH_SOURCE%/*}/docker/build.sh"
