#!/bin/bash
set -e
BASEDIR=$(dirname "$0")

source kong/common.sh

bold "Clean all plugins file..."
rm -rf kong/plugins/*

# Version for different plugin version
PLUGIN_VERSION=1.3.0-3 # for version higher then 1.0.x
#PLUGIN_VERSION=1.2.3-rc # for version lower then 1.0.x
bold "Clone kong-okta-auth-plugin version ${PLUGIN_VERSION}..."
git clone https://github.com/techops-infradel/kong-okta-auth-plugin.git kong/plugins/kong-okta-auth-plugin && \
    cd kong/plugins/kong-okta-auth-plugin &&\
    git checkout tags/v${PLUGIN_VERSION} &&\
    git-crypt unlock

bold "Go back ..."
cd ..

STDOUT_LOG_PLUGIN_VERSION=0.0.2
bold "Clone kong-plugin-stdout-log version ${STDOUT_LOG_PLUGIN_VERSION}..."
git clone https://github.com/rhuanhuan/kong-plugin-stdout-log.git ./kong-plugin-stdout-log && \
    cd ./kong-plugin-stdout-log &&\
    git checkout tags/${STDOUT_LOG_PLUGIN_VERSION}

bold "Go back again..."
cd ..

export VERSION="${1:-0.14.1}"
export PHASE="${2:-starting}"
DOCKER_COMPOSE_SERVICE=apigw-${PHASE}
DOCKER_IMAGE=eu.gcr.io/techops-infradel/platform-api-gateway

bold "Logging docker into gcloud..."
echo "$(gcloud auth print-access-token)" | \
docker login -u oauth2accesstoken --password-stdin https://eu.gcr.io

bold "## INFO: Building image"
docker-compose build $DOCKER_COMPOSE_SERVICE

bold "## INFO: Pushing: $DOCKER_IMAGE:$VERSION"
gcloud docker -- push $DOCKER_IMAGE:$VERSION