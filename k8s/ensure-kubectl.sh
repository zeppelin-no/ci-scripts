#!/bin/sh

K8S_VERSION="v1.8.7"

if [ ! -z "$1" ]; then
  K8S_VERSION="$1"
fi

# if [ -z "${DOCKER_SHA_TAG}" ]; then
#   export DOCKER_SHA_TAG="$(echo $CIRCLE_SHA1 | cut -c -7)"
# fi

if [ -x "$(command -v apk)" ]; then
  echo "Using apk"
  apk update --quiet --no-progress
  PKG_MANAGER='apk add --quiet --no-progress'
elif [ -x "$(command -v apt-get)" ]; then
  echo "Using apt-get"
  PKG_MANAGER='apt-get install --quiet -y'
elif [ -x "$(command -v yum)" ]; then
  echo "Using yum"
  PKG_MANAGER='yum install --quiet -y'
else
  echo "Neither apk, apt-get nor yum found"
  exit 1
fi

if ! [ -x "$(command -v sudo)" ]; then
    echo "Installing sudo"
   ${PKG_MANAGER} sudo
 else
   echo 'Using preinstalled sudo'
fi

if ! [ -x "$(command -v curl)" ]; then
  echo "Installing curl"
  ${PKG_MANAGER} curl
else
  echo 'Using preinstalled curl'
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

kubectl version --client

echo "--- setup complete ---"
