#!/usr/bin/env bash
set -e
source kong/common.sh

# MAIN
export NAMESPACE="platform-kong"

function ensure_namespace() {
#  kubectl delete namespace ${NAMESPACE} || bold " Delete namespace first."
  bold "Ensuring namespace ${NAMESPACE} exists..."
  kubectl create namespace "${NAMESPACE}" 2>/dev/null || bold "Namespace already in place"
}

bold "Login cluster of hyrule-dev"
cluster_login hyrule-dev

ensure_namespace "${NAMESPACE}"

bold "Installing Helm Tiller on k8s cluster"
helm init --force-upgrade

bold "update repo"
helm repo update

bold "Uninstalling kong-server chart"
helm del --purge kong-server-processing || bold "No kong exits."

bold "Installing kong chart"
helm install stable/kong --name kong-server-processing -f kong/values-0.14.1.yaml --namespace ${NAMESPACE} --version 0.7.3


