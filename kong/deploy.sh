#!/usr/bin/env bash
set -e
source kong/common.sh

function set_fqdn() {
   echo "kong.platform-dev.thoughtworks.net"
}

# MAIN
BUCKET=tw-certs
FQDN=$(set_fqdn)
export NAMESPACE="platform-kong"

function ensure_namespace() {
#  kubectl delete namespace ${NAMESPACE} || bold " Delete namespace first."
  bold "Ensuring namespace ${NAMESPACE} exists..."
  kubectl create namespace "${NAMESPACE}" 2>/dev/null || bold "Namespace already in place"
}

function download_certificates {
  bold "## Checking for ACME Client data (certs)"
  if gsutil ls "gs://${BUCKET}/${FQDN}-keys.tgz"; then
    bold "## ACME client data found, downloading and unpacking"
    gsutil cp "gs://${BUCKET}/${FQDN}-keys.tgz" .
    tar zxvf "${FQDN}-keys.tgz"
  else
    echo "## File not found: gs://${BUCKET}/${FQDN}-keys.tgz"
    exit 1
  fi
}

function deploy_certificate_secret() {
  bold "## Deploying certificates files as Kubernetes Secrets"
  kubectl -n ${NAMESPACE} delete secret "tls-secret" || \
  bold "WARNING: Keys for ${FQDN} are not in secrets"

  kubectl -n ${NAMESPACE} create secret tls "tls-secret" \
  --key="./data/certs/${FQDN}/privkey.pem" \
  --cert="./data/certs/${FQDN}/fullchain.pem"
}

#download_certificates
ensure_namespace "${NAMESPACE}"
#deploy_certificate_secret

bold "Login cluster of hyrule-dev"
cluster_login hyrule-dev

bold "Installing Helm Tiller on k8s cluster"
helm init --force-upgrade

bold "Installing kong-ingress"
kubectl delete -f kong/kong-ingress.yml || bold " No kong-ingress exists. "
#kubectl apply -f kong/kong-ingress.yml

bold "update repo"
helm repo update

bold "Installing kong chart"
helm del --purge kong-server || bold "No kong exits."
helm install stable/kong --name kong-server -f kong/values.yaml --namespace ${NAMESPACE}


