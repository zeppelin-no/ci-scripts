#!/bin/sh
echo "DEBUG --- install-packages START  ---"

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

if ! [ -x "$(command -v aws)" ]; then
  # TODO this is possibly not package manager agnostic
  echo "Installing aws-cli"
  ${PKG_MANAGER} python3
  pip3 install awscli
else
   echo 'Using preinstalled aws-cli'
fi
