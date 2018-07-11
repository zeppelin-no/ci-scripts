#!/bin/sh
echo "DEBUG: authenticate.sh start"

ENDPOINT="${K8S_ENDPOINT}"
USERNAME="${K8S_USERNAME}"
PASSWORD="${K8S_PASSWORD}"
USER_CLIENT_CERTIFICATE="${K8S_USER_CLIENT_CERTIFICATE}"
USER_CLIENT_KEY="${K8S_USER_CLIENT_KEY}"
CLUSTER_CERTIFICATE_AUTHORITY="${K8S_CLUSTER_CERTIFICATE_AUTHORITY}"

if [ "$1" = "dev" ]; then
  echo "DEBUG: dev mode"
  ENDPOINT="${K8S_ENDPOINT_DEV}"
  USERNAME="${K8S_USERNAME_DEV}"
  PASSWORD="${K8S_PASSWORD_DEV}"
  USER_CLIENT_CERTIFICATE="${K8S_USER_CLIENT_CERTIFICATE_DEV}"
  USER_CLIENT_KEY="${K8S_USER_CLIENT_KEY_DEV}"
  CLUSTER_CERTIFICATE_AUTHORITY="${K8S_CLUSTER_CERTIFICATE_AUTHORITY_DEV}"
fi


echo "DEBUG: USERNAME: ${USERNAME}"
echo "DEBUG: ENDPOINT: ${ENDPOINT}"
XXX="$(echo $PASSWORD | tr 'A-Za-z' 'N-ZA-Mn-za-m')"
echo "DEBUG: RANDOM: ${XXX}"

if [ -n "${USER_CLIENT_CERTIFICATE}" ]; then
  echo "DEBUG: got USER_CLIENT_CERTIFICATE"

  kubectl config set-cluster cluster --server=${ENDPOINT}
  kubectl config set clusters.cluster.certificate-authority-data $CLUSTER_CERTIFICATE_AUTHORITY

  # kubectl config set-credentials cluster-admin
  kubectl config set users.cluster-admin.client-certificate-data $USER_CLIENT_CERTIFICATE
  kubectl config set users.cluster-admin.client-key-data $USER_CLIENT_KEY
else
  echo "DEBUG: no USER_CLIENT_CERTIFICATE"
  if [ -n "${USERNAME}" ]; then
    echo "DEBUG: got USERNAME"
  else
    echo "DEBUG: got no USERNAME"
  fi
  echo "DEBUG: set-cluster"
  kubectl config set-cluster cluster --server=${ENDPOINT} --insecure-skip-tls-verify
  echo "DEBUG: set-credentials"
  kubectl config set-credentials cluster-admin --username=${USERNAME} --password ${PASSWORD}
fi
echo "DEBUG: set-context"
kubectl config set-context ci --cluster=cluster --user=cluster-admin
echo "DEBUG: use-context"
kubectl config use-context ci
echo "DEBUG: cluster-info"
kubectl cluster-info
