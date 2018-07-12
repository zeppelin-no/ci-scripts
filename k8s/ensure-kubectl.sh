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

if [ -x "$(command -v apk)" ]; then
  # echo "Using apk"
  PKG_MANAGER='apk add --quiet'
elif [ -x "$(command -v apt-get)" ]; then
  # echo "Using apt-get"
  PKG_MANAGER='apt-get install -y'
elif [ -x "$(command -v yum)" ]; then
  # echo "Using yum"
  PKG_MANAGER='yum install -y'
else
  echo "Neither apk, apt-get nor yum found"
  exit 1
fi

if ! [ -x "$(command -v envsubst)" ]; then
  echo "Installing gettext"
  ${PKG_MANAGER} gettext
else
  echo 'Using preinstalled gettext'
fi

if ! [ -x "$(command -v docker)" ]; then
    echo "Installing docker"
   ${PKG_MANAGER} docker
 else
   echo 'Using preinstalled docker'
fi

if ! [ -x "$(command -v aws)" ]; then
  # TODO this is possibly not package manager agnostic
  echo "Installing aws-cli"
  ${PKG_MANAGER} python3
  pip3 install awscli
else
   echo 'Using preinstalled aws-cli'
fi

if ! [ -x "$(command -v kubectl)" ]; then
  if ! [ -x "$(command -v curl)" ]; then
    echo "Installing curl"
    ${PKG_MANAGER} curl
  else
    echo 'Using preinstalled curl'
  fi
  echo "Downloading kubectl $K8S_VERSION ..."
  curl -LOsS "https://storage.googleapis.com/kubernetes-release/release/$K8S_VERSION/bin/linux/amd64/kubectl"
  # Make the kubectl binary executable.
  chmod +x kubectl
  # Move the binary in to your PATH.
  mv kubectl /usr/local/bin/kubectl
  echo 'kubectl is installed!'
else
  echo 'Using preinstalled kubectl'
fi

echo "--- ensure kubectl Complete  ---"
kubectl version --client
