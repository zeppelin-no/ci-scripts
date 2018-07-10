#!/bin/sh

ENDPOINT="${K8S_ENDPOINT}"
USERNAME="${K8S_USERNAME}"
PASSWORD="${K8S_PASSWORD}"
USER_CLIENT_CERTIFICATE="${K8S_USER_CLIENT_CERTIFICATE}"
USER_CLIENT_KEY="${K8S_USER_CLIENT_KEY}"
CLUSTER_CERTIFICATE_AUTHORITY="${K8S_CLUSTER_CERTIFICATE_AUTHORITY}"

if [ "$1" = "dev" ]; then
  ENDPOINT="${K8S_ENDPOINT_DEV}"
  USERNAME="${K8S_USERNAME_DEV}"
  PASSWORD="${K8S_PASSWORD_DEV}"
  USER_CLIENT_CERTIFICATE="${K8S_USER_CLIENT_CERTIFICATE_DEV}"
  USER_CLIENT_KEY="${K8S_USER_CLIENT_KEY_DEV}"
  CLUSTER_CERTIFICATE_AUTHORITY="${K8S_CLUSTER_CERTIFICATE_AUTHORITY_DEV}"
fi

if [ -n "${USER_CLIENT_CERTIFICATE}" ]; then
  echo "got USER_CLIENT_CERTIFICATE"

  kubectl config set-cluster cluster \
    --server=${ENDPOINT}
  kubectl config set clusters.cluster.certificate-authority-data $CLUSTER_CERTIFICATE_AUTHORITY

  # kubectl config set-credentials cluster-admin
  kubectl config set users.cluster-admin.client-certificate-data $USER_CLIENT_CERTIFICATE
  kubectl config set users.cluster-admin.client-key-data $USER_CLIENT_KEY
else
  if [ -n "${USERNAME}" ]; then
    echo "got USERNAME"
  else
    echo "got no USERNAME"
  fi
  echo "no USER_CLIENT_CERTIFICATE"
  kubectl config set-cluster cluster --server=${ENDPOINT} --insecure-skip-tls-verify
  kubectl config set-credentials cluster-admin --username=${USERNAME} --password ${PASSWORD}
fi

kubectl config set-context ci --cluster=cluster --user=cluster-admin
kubectl config use-context ci

kubectl cluster-info
