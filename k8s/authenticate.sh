#!/bin/sh
echo "DEBUG --- k8s authenticate START  ---"
# For testing locally, (see localenv.sh.sample)
localenv="./localenv.sh"
if [ -f "$localenv" ]; then
  source "$localenv"
else
    echo "Optional '${localenv}' not found."
fi

ENDPOINT="${K8S_ENDPOINT}"
USERNAME="${K8S_USERNAME}"
PASSWORD="${K8S_PASSWORD}"
USER_CLIENT_CERTIFICATE="${K8S_USER_CLIENT_CERTIFICATE}"
USER_CLIENT_KEY="${K8S_USER_CLIENT_KEY}"
CLUSTER_CERTIFICATE_AUTHORITY="${K8S_CLUSTER_CERTIFICATE_AUTHORITY}"

if [ "$1" = "dev" ]; then
  echo "DEBUG: dev mode"
  ENDPOINT="${K8S_DEV_ENDPOINT}"
  USERNAME="${K8S_DEV_USERNAME}"
  PASSWORD="${K8S_DEV_PASSWORD}"
  USER_CLIENT_CERTIFICATE="${K8S_DEV_USER_CLIENT_CERTIFICATE}"
  USER_CLIENT_KEY="${K8S_DEV_USER_CLIENT_KEY}"
  CLUSTER_CERTIFICATE_AUTHORITY="${K8S_DEV_CLUSTER_CERTIFICATE_AUTHORITY}"
fi

# # Used for dumping login credentials slightly obfuscated:
# echo "DEBUG: USERNAME: ${USERNAME}"
# echo "DEBUG: ENDPOINT: ${ENDPOINT}"
# # Obfuscate the password with rot13:
# XXX="$(echo $PASSWORD | tr 'A-Za-z' 'N-ZA-Mn-za-m')"
# echo "DEBUG: RANDOM: ${XXX}"
# ## To get the unscrambled PASSWORD use
# ## echo 'THE RANDOM STRING HERE' | tr 'A-Za-z' 'N-ZA-Mn-za-m'

if [ -n "${USER_CLIENT_CERTIFICATE}" ]; then
  echo "DEBUG: got USER_CLIENT_CERTIFICATE"

  kubectl config set-cluster cluster --server=${ENDPOINT}
  kubectl config set clusters.cluster.certificate-authority-data $CLUSTER_CERTIFICATE_AUTHORITY

  # kubectl config set-credentials cluster-admin
  kubectl config set users.cluster-admin.client-certificate-data $USER_CLIENT_CERTIFICATE
  kubectl config set users.cluster-admin.client-key-data $USER_CLIENT_KEY
else
  echo "DEBUG: no certificate defined; using username + password"
  # echo "DEBUG: set-cluster"
  kubectl config set-cluster cluster --server=${ENDPOINT} --insecure-skip-tls-verify
  # echo "DEBUG: set-credentials"
  kubectl config set-credentials cluster-admin --username=${USERNAME} --password ${PASSWORD}
fi
kubectl config set-context ci --cluster=cluster --user=cluster-admin
kubectl config use-context ci

# This is mostly for debugging right?
kubectl version
kubectl cluster-info
