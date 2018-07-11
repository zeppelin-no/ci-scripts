#!/bin/sh

./k8s/ensure-kubectl.sh
kubectl version --client
./k8s/authenticate.sh
echo "DEBUG: get all pods"
kubectl get pods --all-namespaces
echo "DEBUG: authenticate DEV"
./k8s/authenticate.sh dev
