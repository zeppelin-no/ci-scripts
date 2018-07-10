#!/bin/sh

K8S_VERSION="v1.8.7"

if [ ! -z "$1" ]; then
  K8S_VERSION="$1"
fi

if [ -z "${DOCKER_SHA_TAG}" ]; then
  export DOCKER_SHA_TAG=$(echo $CIRCLE_SHA1 | cut -c -7)
fi

apk update

# PKG_MANAGER=$( command -v yum || command -v apt-get ) || echo "Neither yum nor apt-get found"
# PKG_MANAGER=$( which yum || which apt-get ) || echo "Neither yum nor apt-get found"

#make sure sudo is installed
if [ ! -e "/usr/bin/sudo" ]; then
   apk add sudo
fi
#
# # remove default setting of requiretty if it exists
# sed -i '/Defaults requiretty/d' /etc/sudoers

#make sure curl is installed
if [ ! -e "/usr/bin/curl" ]; then
   apk add curl
fi

# #make sure jq is installed
# if [ ! -e "/usr/bin/jq" ]; then
#     ${PKG_MANAGER} install -y jq
# fi
# ${PKG_MANAGER} install -y gettext

#make sure envsubst is installed
if [ ! -e "/usr/bin/envsubst" ]; then
  apk add gettext
fi

# make the temp directory
if [ ! -e ~/.kube ]; then
    mkdir -p ~/.kube;
fi

if [ ! -e ~/.kube/kubectl ]; then
  # Download kubectl

  curl -LO "https://storage.googleapis.com/kubernetes-release/release/$K8S_VERSION/bin/linux/amd64/kubectl"
  # curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.11.0/bin/linux/amd64/kubectl
  # Make the kubectl binary executable.
  chmod +x kubectl
  # Move the binary in to your PATH.
  sudo mv kubectl /usr/local/bin/kubectl
fi

kubectl version --client
