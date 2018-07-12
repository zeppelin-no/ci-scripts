#!/bin/sh
echo "DEBUG --- ecr authenticate START  ---"
aws --version
eval "$(aws ecr get-login --region eu-west-1 --no-include-email)"
# aws ecr get-login --region eu-west-1
