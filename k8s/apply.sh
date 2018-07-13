#!/bin/sh
# echo "DEBUG --- k8s apply START  ---"
if [ "$#" -eq 0 ] ; then
    echo 'Needs k8s namespace as first argument'
    exit 1
fi
K8S_NAMESPACE=$1
DOCKER_SHA_TAG="$(echo $CIRCLE_SHA1 | cut -c -7)"

TAG="${DOCKER_SHA_TAG}"

if [ ! -z "$2" ]; then
  TAG=$2
fi

export VERSION=${TAG}

# echo "-----------------------"
# echo "CIRCLE_SHA1: $CIRCLE_SHA1"
# echo "DOCKER_SHA_TAG: $DOCKER_SHA_TAG"
# echo "TAG: $TAG"
# echo "VERSION: $VERSION"
# echo "K8S_NAMESPACE: $K8S_NAMESPACE"
# echo "-----------------------"

mkdir -p k8s/.generated

for f in ./k8s/*.yml
do
  envsubst < $f > "./k8s/.generated/$(basename $f)"
done
kubectl apply -f ./k8s/.generated/ --namespace="$K8S_NAMESPACE"
