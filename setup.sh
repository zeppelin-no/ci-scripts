#!/bin/bash

DIR=$(dirname "${BASH_SOURCE[0]}")

./${DIR}/k8s/ensure-kubectl.sh
./${DIR}/k8s/authenticate.sh

./${DIR}/ecr/authenticate.sh
