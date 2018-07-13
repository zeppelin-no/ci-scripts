#!/bin/sh
echo "DEBUG --- ensure kubectl START  ---"

# Current latest version:
K8S_VERSION="v1.11.0"

# The version from the current master:
# K8S_VERSION="v1.8.7"

# The version used in 0.1.0 tag
# K8S_VERSION="v1.5.4"

if [ ! -z "$1" ]; then
  K8S_VERSION="$1"
fi

# NOTE: Ideally these scripts should be run with a docker image with
# gettext, docker, aws-cli, curl and kubectl preinstalled, this is just in case it's not.

# ASSUMPTIONS:
# The package names is the ones used in Alpine linux and I think they're also the same in most Debian based distros.
# This script will try to use apk, apt-get or yum to install but if some packages or executables is not named the
# same on another distro it might not work even though it has the correct package manager.

if [ -x "$(command -v apk)" ]; then
  # Alpine linux
  PKG_MANAGER='apk add --quiet'
elif [ -x "$(command -v apt-get)" ]; then
  # Debian based linux
  PKG_MANAGER='apt-get install -y'
elif [ -x "$(command -v yum)" ]; then
  # RHEL based linux
  PKG_MANAGER='yum install -y'
else
  echo "Neither apk, apt-get nor yum found"
  exit 1
fi

# ASSUMPTION: 'envsubst' command is in package named 'gettext'
if ! [ -x "$(command -v envsubst)" ]; then
  echo "Installing gettext"
  ${PKG_MANAGER} gettext
else
  echo 'Using preinstalled gettext'
fi
# ASSUMPTION: 'docker' command is in package named 'docker'
if ! [ -x "$(command -v docker)" ]; then
    echo "Installing docker"
   ${PKG_MANAGER} docker
 else
   echo 'Using preinstalled docker'
fi
# ASSUMPTION: 'pip3' command is in package named 'python3'
if ! [ -x "$(command -v aws)" ]; then
  echo "Installing aws-cli"
  ${PKG_MANAGER} python3
  pip3 install awscli
else
   echo 'Using preinstalled aws-cli'
fi
# ASSUMPTION: 'curl' command is in package named 'curl'
# ASSUMPTION: the running process can move kubectl to /usr/local/bin/ wihtout sudo.
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
