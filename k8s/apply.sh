#!/bin/bash

TAG=${DOCKER_SHA_TAG}

if [[ ! -z $1 ]]; then
  TAG=$1
fi

export VERSION=${TAG}

mkdir -p k8s/.generated

for f in ./k8s/*.yml
do
  envsubst < $f > "./k8s/.generated/$(basename $f)"
done

# kubectl apply -f ./deploy/.generated/
