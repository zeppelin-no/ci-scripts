#!/bin/sh

# Restart pods for a stateful set by deleting the old ones.
#
# Takes two ordered arguments:
#   - appname     The name of the stateful set.
#   - namespace   The kubernetes namespace to use.
#
#  Example: to restart the pods for the stateful set "drebbel":
#  ./restart_pods.sh drebbel prod

APP_NAME=$1
K8S_NAMESPACE=$2

echo "Deleting pods labeled app:${APP_NAME} in namespace ${K8S_NAMESPACE}..."
kubectl delete pods -l app=${APP_NAME} --namespace=${K8S_NAMESPACE}
echo "Pods restarting."
