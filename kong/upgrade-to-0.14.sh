#!/usr/bin/env bash
set -e
source kong/common.sh

# MAIN
BUCKET=tw-certs
FQDN=$(set_fqdn)
export NAMESPACE="platform-kong"

function ensure_namespace() {
#  kubectl delete namespace ${NAMESPACE} || bold " Delete namespace first."
  bold "Ensuring namespace ${NAMESPACE} exists..."
  kubectl create namespace "${NAMESPACE}" 2>/dev/null || bold "Namespace already in place"
}

ensure_namespace "${NAMESPACE}"

bold "Login cluster of hyrule-dev"
cluster_login hyrule-dev

bold "Installing Helm Tiller on k8s cluster"
helm init --force-upgrade

bold "update repo"
helm repo update

bold "Uninstalling kong-server chart"
helm del --purge kong-server-0.14 || bold "No kong exits."

bold "Installing kong chart"
helm install stable/kong --name kong-server-0.14 -f kong/values-0.14.yaml --namespace ${NAMESPACE} --version 0.4.1


