#!/bin/bash

ENDPOINT=${K8S_ENDPOINT}
USERNAME=${K8S_USERNAME}
PASSWORD=${K8S_PASSWORD}
CLIENT_CERTIFICATE=${K8S_CERTIFICATE}
CLIENT_KEY=${K8S_KEY}
CLUSTER_CERTIFICATE=${K8S_CLUSTER_CERTIFICATE}

if [ "$1" = "dev" ]; then
  ENDPOINT=${K8S_ENDPOINT_DEV}
  USERNAME=${K8S_USERNAME_DEV}
  PASSWORD=${K8S_PASSWORD_DEV}
  CLIENT_CERTIFICATE=${K8S_CERTIFICATE_DEV}
  CLIENT_KEY=${K8S_KEY_DEV}
  CLUSTER_CERTIFICATE=${K8S_CLUSTER_CERTIFICATE_DEV}
fi

if [ -n "${CLIENT_CERTIFICATE}" ]; then
  echo "got CLIENT_CERTIFICATE"

  kubectl config set-cluster cluster \
    --server=${ENDPOINT}
  kubectl config set clusters.cluster.certificate-authority-data $CLUSTER_CERTIFICATE

  # kubectl config set-credentials cluster-admin
  kubectl config set users.cluster-admin.client-certificate-data $CLIENT_CERTIFICATE
  kubectl config set users.cluster-admin.client-key-data $CLIENT_KEY
else
  echo "no CLIENT_CERTIFICATE"

  kubectl config set-cluster cluster --server=${ENDPOINT} --insecure-skip-tls-verify
  kubectl config set-credentials cluster-admin \
    --username=${USERNAME} \
    --password ${PASSWORD}
fi


kubectl config set-context ci --cluster=cluster --user=cluster-admin --namespace="$1"
kubectl config use-context ci

kubectl cluster-info
