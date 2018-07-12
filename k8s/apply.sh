#!/bin/sh
echo "DEBUG --- k8s apply START  ---"
if [ "$#" -eq 0 ] ; then
    echo 'Needs k8s namespace as first argument'
    exit 1
fi
echo "-----------------------"
echo "Working dir:"
pwd
echo "-----------------------"
DOCKER_SHA_TAG="$(echo $CIRCLE_SHA1 | cut -c -7)"

TAG="${DOCKER_SHA_TAG}"

if [ ! -z "$2" ]; then
  TAG=$2
fi

export VERSION=${TAG}

echo "CIRCLE_SHA1: $CIRCLE_SHA1"
echo "DOCKER_SHA_TAG: $DOCKER_SHA_TAG"
echo "TAG: $TAG"
echo "VERSION: $VERSION"
echo "-----------------------"

mkdir -p k8s/.generated

for f in ./k8s/*.yml
do
  envsubst < $f > "./k8s/.generated/$(basename $f)"
done
echo "========= listing files in k8s/"
ls ./k8s/
echo "========= dumping content of k8s/ files"
cat ./k8s/*
echo "========= listing files in k8s/.generated/"
ls ./k8s/.generated
echo "========= dumping content of k8s/.generated/ files"
cat ./k8s/.generated/*
echo "-----------------------"
kubectl apply -f ./k8s/.generated/
