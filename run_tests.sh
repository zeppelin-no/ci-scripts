#!/bin/sh

./k8s/ensure-kubectl.sh v1.5.4
kubectl version --client
./k8s/authenticate.sh
kubectl get pods --all-namespaces