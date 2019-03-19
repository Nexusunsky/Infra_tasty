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
helm del --purge kong-server-finishing || bold "No kong exits."

bold "migration kong jobs"
kubectl delete -f kong/migration || bold "No migration job exits."
kubectl apply -f kong/migration

bold "Installing kong chart"
helm install stable/kong --name kong-server-finishing -f kong/values-1.0.3.yaml --namespace ${NAMESPACE} --version 0.9.7


