#!/bin/bash

export TERM=xterm-256color

sbold=$(tput bold)
snormal=$(tput sgr0)

function bold {
  echo "${sbold}$*${snormal}"
}

function cluster_login() {
  CLUSTER=$1
  gcloud container clusters get-credentials $CLUSTER -z europe-west1-c
}

