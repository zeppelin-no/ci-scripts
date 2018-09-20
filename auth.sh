#!/bin/sh

# Authenticates to ecr and kubernetes
#
# Takes one argument:
#   - type        The kubernetes type to authenticate ('dev' or 'prod')
#

DIR=$(dirname "$0")

K8S_TYPE=$1
# ie "dev" or any other string is non-dev

${DIR}/ecr/authenticate.sh
${DIR}/k8s/authenticate.sh ${K8S_TYPE}
