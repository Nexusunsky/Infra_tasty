#!/usr/bin/env bash

password: rwIf1xgen5accG40

apk add --update \
    curl \
    && rm -rf /var/cache/apk/*

export host="http://104.199.107.43:8444"
export proxy="https://35.233.29.223"

# ADMIN
curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --request POST \
  --data '{"name": "Admin-service", "url": "http://127.0.0.1:8444"}' \
  --url ${host}/services

curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --request POST \
  --data '{"name": "Admin-route", "methods": ["GET", "POST", "PUT", "DELETE"], "protocols": ["http", "https"], "paths": ["/admin"] }' \
  --url ${host}/services/Admin-service/routes

curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --request GET \
  --url ${host}/admin

curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --request GET \
  --url ${host}/

// Get All Services
curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --request GET \
  --url ${host}/services

// Admin interface
curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --request GET \
  --url ${host}/admin

curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --request GET \
  --url ${host}/admin
