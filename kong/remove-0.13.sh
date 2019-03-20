#!/usr/bin/env bash
set -e
source kong/common.sh

bold "Uninstalling kong-server-starting "
helm del --purge kong-server-starting || bold "No kong exits."



