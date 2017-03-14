#!/bin/bash

kubectl config set-cluster cluster --server=${K8S_ENDPOINT} --insecure-skip-tls-verify
kubectl config set-credentials cluster-admin --username=${K8S_USERNAME} --password ${K8S_PASSWORD}

kubectl config set-context ci --cluster=cluster --user=cluster-admin
kubectl config use-context ci

kubectl cluster-info
