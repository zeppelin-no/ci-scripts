#!/bin/bash

ENDPOINT=${K8S_ENDPOINT}
USERNAME=${K8S_USERNAME}
PASSWORD=${K8S_PASSWORD}
CLIENT_CERTIFICATE=${K8S_CERTIFICATE}
CLIENT_KEY=${K8S_KEY}

if [ "$1" = "dev" ]; then
  ENDPOINT=${K8S_ENDPOINT_DEV}
  USERNAME=${K8S_USERNAME_DEV}
  PASSWORD=${K8S_PASSWORD_DEV}
  CLIENT_CERTIFICATE=${K8S_CERTIFICATE_DEV}
  CLIENT_KEY=${K8S_KEY_DEV}
fi

echo "CLIENT_CERTIFICATE"
echo "$CLIENT_CERTIFICATE"
echo "CLIENT_CERTIFICATE"

if [ -z "${CLIENT_CERTIFICATE+x}" ]; then
  echo "no CLIENT_CERTIFICATE"

  kubectl config set-cluster cluster --server=${ENDPOINT} --insecure-skip-tls-verify
  kubectl config set-credentials cluster-admin \
  --username=${USERNAME} \
  --password ${PASSWORD}
else
  echo "got CLIENT_CERTIFICATE"
  echo $CLIENT_CERTIFICATE > ca.tmp.pem
  echo $CLIENT_KEY > key.tmp.pem

  kubectl config set-cluster cluster --server=${ENDPOINT}
  kubectl config set-credentials cluster-admin \
  --client-certificate=ca.tmp.pem \
  --client-key=key.tmp.pem \
  --embed-certs=true
fi


kubectl config set-context ci --cluster=cluster --user=cluster-admin
kubectl config use-context ci

kubectl cluster-info
