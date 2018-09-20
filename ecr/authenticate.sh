#!/bin/sh
# echo "DEBUG --- ecr authenticate START  ---"
eval "$(aws ecr get-login --region eu-west-1 --no-include-email)"
