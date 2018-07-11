#!/bin/sh

DIR=$(dirname "$0")

${DIR}/k8s/ensure-kubectl.sh
${DIR}/k8s/authenticate.sh

${DIR}/ecr/authenticate.sh
