#!/bin/bash
set -e
source color.sh

bold "Starting kong..."
bold "Inject kong.conf"
kong prepare -p "/usr/local/kong" --vv

bold "Running migrations..."
kong migrations up -c /usr/local/bin/kong.conf --vv
kong migrations finish -vv

#kong migrations bootstrap

bold "Starting Kong..."
/usr/local/openresty/nginx/sbin/nginx -c /usr/local/kong/nginx.conf -p /usr/local/kong/
