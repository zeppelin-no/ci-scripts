#!/bin/bash

kubectl version

K8S_VERSION=$(kubectl version --client=false --short | grep Server | sed -n -e 's/^.*\(v.\)/\1/p' | cut -f1 -d+)

echo $K8S_VERSION

if [[ ! -z $1 ]]; then
  K8S_VERSION=$1
fi

PKG_MANAGER=$( command -v yum || command -v apt-get ) || echo "Neither yum nor apt-get found"

#make sure sudo is installed
if [ ! -e "/usr/bin/sudo" ]; then
   ${PKG_MANAGER} install -y sudo
fi

# remove default setting of requiretty if it exists
sed -i '/Defaults requiretty/d' /etc/sudoers

#make sure wget is installed
if [ ! -e "/usr/bin/wget" ]; then
   ${PKG_MANAGER} install -y wget
fi

#make sure jq is installed
if [ ! -e "/usr/bin/jq" ]; then
    ${PKG_MANAGER} install -y jq
fi

#make sure envsubst is installed
if [ ! -e "/usr/bin/envsubst" ]; then
    ${PKG_MANAGER} install -y gettext
fi

# make the temp directory
if [ ! -e ~/.kube ]; then
    mkdir -p ~/.kube;
fi

if [ ! -e ~/.kube/kubectl ]; then
    wget https://storage.googleapis.com/kubernetes-release/release/${K8S_VERSION}/bin/linux/amd64/kubectl -O /home/ubuntu/bin/kubectl
    chmod +x /home/ubuntu/bin/kubectl
fi

kubectl version --client
