#!/usr/bin/env bash

password: rwIf1xgen5accG40

apk add --update \
    curl \
    && rm -rf /var/cache/apk/*

# ADMIN
curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --request POST \
  --data '{"name": "Admin-service", "url": "http://127.0.0.1:8444"}' \
  --url http://0.0.0.0:8444/services

curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --request POST \
  --data '{"name": "Admin-route", "methods": ["GET", "POST", "PUT", "DELETE"], "protocols": ["http", "https"], "paths": ["/admin"] }' \
  http://0.0.0.0:8444/services/Admin-service/routes

curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --request GET \
  http://127.0.0.1:8000/admin

curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --request GET \
  http://127.0.0.1:8444/

// Get All Services
curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --request GET \
  http://127.0.0.1:8444/services

// Admin interface
curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --request GET \
  http://127.0.0.1:8000/admin

curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --request GET \
  http://10.47.244.239:80/admin
