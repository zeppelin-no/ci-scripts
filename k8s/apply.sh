#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo 'Needs k8s namespace as first argument'
    exit 1
fi

TAG=${DOCKER_SHA_TAG}

if [[ ! -z $2 ]]; then
  TAG=$2
fi

export VERSION=${TAG}

mkdir -p k8s/.generated

for f in ./k8s/*.yml
do
  envsubst < $f > "./k8s/.generated/$(basename $f)"
done

kubectl apply -f ./k8s/.generated/
