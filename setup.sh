#!/bin/sh
echo "DEBUG --- setup.sh START  ---"
DIR=$(dirname "$0")

${DIR}/install-packages.sh
${DIR}/k8s/ensure-kubectl.sh
echo 'authenticate k8s'
${DIR}/k8s/authenticate.sh
echo 'authenticate ecr'
${DIR}/ecr/authenticate.sh
