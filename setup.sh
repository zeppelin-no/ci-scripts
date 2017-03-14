#!/bin/bash

source "${BASH_SOURCE%/*}/k8s/ensure-kubectl.sh"
source "${BASH_SOURCE%/*}/k8s/authenticate.sh"

source "${BASH_SOURCE%/*}/ecr/authenticate.sh"
