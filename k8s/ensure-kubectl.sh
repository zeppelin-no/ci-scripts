#!/bin/sh
echo "DEBUG --- ensure kubectl START  ---"
# Current latest version:
# K8S_VERSION="v1.11.0"
# The version from the current master:
# K8S_VERSION="v1.8.7"
# The version used in 0.1.0 tag
K8S_VERSION="v1.5.4"

if [ ! -z "$1" ]; then
  K8S_VERSION="$1"
fi

if ! [ -x "$(command -v kubectl)" ]; then
  echo "Downloading kubectl $K8S_VERSION ..."
  curl -LOsS "https://storage.googleapis.com/kubernetes-release/release/$K8S_VERSION/bin/linux/amd64/kubectl"
  # Make the kubectl binary executable.
  chmod +x kubectl
  # Move the binary in to your PATH.
  sudo mv kubectl /usr/local/bin/kubectl
  echo 'kubectl is installed!'
else
  echo 'Using preinstalled kubectl'
fi

echo "--- ensure kubectl Complete  ---"
kubectl version --client
