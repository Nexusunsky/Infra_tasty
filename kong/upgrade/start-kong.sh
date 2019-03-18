#!/bin/bash
set -e
source color.sh

bold "Starting kong..."
bold "Inject kong.conf"
kong prepare -p "/usr/local/kong" -c /usr/local/bin/kong.conf --vv
/usr/local/openresty/nginx/sbin/nginx -c /usr/local/kong/nginx.conf -p /usr/local/kong/
