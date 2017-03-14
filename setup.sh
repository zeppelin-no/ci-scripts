#!/bin/bash

./k8s/ensure-kubectl.sh
./k8s/authenticate.sh

./ecr/authenticate.sh
