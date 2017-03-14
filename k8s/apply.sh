#!/bin/bash

TAG=${1}
export VERSION=${TAG}

mkdir -p k8s/.generated

for f in ./k8s/*.yml
do
  envsubst < $f > "./k8s/.generated/$(basename $f)"
done

# kubectl apply -f ./deploy/.generated/
