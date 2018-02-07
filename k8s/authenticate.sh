#!/bin/bash

ENDPOINT=${K8S_ENDPOINT}
USERNAME=${K8S_ENDPOINT}
PASSWORD=${K8S_ENDPOINT}

if [ "$1" = "dev" ]; then
  ENDPOINT=${K8S_ENDPOINT_DEV}
  USERNAME=${K8S_ENDPOINT_DEV}
  PASSWORD=${K8S_ENDPOINT_DEV}
fi

kubectl config set-cluster cluster --server=ENDPOINT --insecure-skip-tls-verify
kubectl config set-credentials cluster-admin --username=USERNAME --password PASSWORD

kubectl config set-context ci --cluster=cluster --user=cluster-admin
kubectl config use-context ci

kubectl cluster-info
