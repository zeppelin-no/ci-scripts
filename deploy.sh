#!/bin/bash

source "${BASH_SOURCE%/*}/docker/push.sh" $2
source "${BASH_SOURCE%/*}/k8s/apply.sh" $1 $2
