#!/usr/bin/env bash
set -e
source kong/common.sh

bold "Uninstalling kong-server-processing "
helm del --purge kong-server-processing || bold "No kong exits."



