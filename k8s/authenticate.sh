#!/bin/bash

~/.kube/kubectl config set-cluster cluster --server=${K8S_ENDPOINT}
~/.kube/kubectl config set-credentials cluster-admin --username=${K8S_USERNAME} --password ${K8S_PASSWORD}

~/.kube/kubectl config set-context ci --cluster=cluster --user=cluster-admin
~/.kube/kubectl config use-context ci

~/.kube/kubectl config view
