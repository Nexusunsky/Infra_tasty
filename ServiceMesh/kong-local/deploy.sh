#!/usr/bin/env bash

set -e
source common.sh

bold "Run Service Mesh"
docker run -it \
       --name service-mesh-dev \
       -v /var/run/docker.sock:/var/run/docker.sock \
       --cap-add=NET_ADMIN --cap-add=NET_RAW \
       service-mesh-kong:dev \
       /bin/sh -c '
docker run -d --name kong-database \
               --network=kong-net \
               -p 5432:5432 \
               -e "POSTGRES_USER=kong" \
               -e "POSTGRES_DB=kong" \
               postgres:9.6;

docker run --rm \
        --network=kong-net \
        -e "KONG_DATABASE=postgres" \
        -e "KONG_PG_HOST=kong-database" \
        -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
        kong:latest kong migrations bootstrap;

docker run -d --name kong \
     --network=kong-net \
     -e "KONG_DATABASE=postgres" \
     -e "KONG_PG_HOST=kong-database" \
     -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
     -e "KONG_PROXY_ACCESS_LOG=/dev/stdout" \
     -e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" \
     -e "KONG_PROXY_ERROR_LOG=/dev/stderr" \
     -e "KONG_ADMIN_ERROR_LOG=/dev/stderr" \
     -e "KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl" \
     -p 8000:8000 \
     -p 8443:8443 \
     -p 8001:8001 \
     -p 8444:8444 \
     kong:latest;
'
