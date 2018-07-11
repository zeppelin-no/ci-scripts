#!/bin/sh

./k8s/ensure-kubectl.sh
./k8s/authenticate.sh
echo "DEBUG: get all pods"
kubectl get pods --all-namespaces
