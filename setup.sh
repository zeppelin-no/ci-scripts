#!/bin/sh
echo "DEPRECTATED use ensure-tools.sh (only if needed) and auth.sh"

DIR=$(dirname "$0")

${DIR}/ensure-tools.sh
${DIR}/k8s/authenticate.sh
${DIR}/ecr/authenticate.sh
