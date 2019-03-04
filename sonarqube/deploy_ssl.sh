#!/usr/bin/env bash
set -e
source sonarqube/common.sh

function set_fqdn() {
   echo "sonar.platform.thoughtworks.net"
}

# MAIN
BUCKET=tw-certs
FQDN=$(set_fqdn)
export NAMESPACE="platform-sonarqube"

function ensure_namespace() {
  bold "Ensuring namespace ${NAMESPACE} exists..."
  kubectl create namespace "${NAMESPACE}" 2>/dev/null || \
  bold "Namespace already in place"
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

download_certificates
ensure_namespace "${NAMESPACE}"
deploy_certificate_secret

bold "Login cluster of hyrule-prod"
cluster_login hyrule-dev

bold "Installing Helm Tiller on k8s cluster"
helm init --force-upgrade

bold "Installing sonarqube-ingress"
kubectl apply -f sonarqube/sonarqube-ingress.yml

bold "update repo"
helm repo update

bold "Installing sonarqube chart"
helm del --purge sonarqube-server
helm install stable/sonarqube --name sonarqube-server -f sonarqube/values.yaml --namespace platform-sonarqube
