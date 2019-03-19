#!/usr/bin/env bash

password: rwIf1xgen5accG40

# 1 Install Git
# 2 Git Clone https://github.com/techops-infradel/kong-okta-auth-plugin.git
# cp dir
# Restart kong and enable plugin.

apk add --update \
    curl \
    && rm -rf /var/cache/apk/*

export host="127.0.0.1:8444"
export proxy="35.241.202.149"

# Kong Admin
curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --request GET \
  --url ${host}/

# Api ADMIN
curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --request POST \
  --data '{"name": "Api-Admin", "upstream_url": "http://127.0.0.1:8444", "uris": "/admin"}' \
  --url ${host}/apis

# Enable okta plugin
curl -X POST ${host}/apis/Api-Admin/plugins \
  --data "name=okta-auth" \
  --data "config.authorization_server=https://dev-395756.oktapreview.com/oauth2/ausfaflnedhSTSp9Z0h7" \
  --data "config.client_id=0oajbvf7452YoU32E0h7" \
  --data "config.client_secret=jPVHgU8HpNpha4JGCAjpO9HLj_59AtPZNiAUZ7Eh" \
  --data "config.api_version=v1" \
  --data "config.check_auth_server=true"

# Admin interface
curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --header "Authorization: Bearer eyJraWQiOiJ2cXJUcUk0Y3BzUmN0Z2I1bW52QmxFdUpDVGlmcHM4VG1mcnUxdDJSLXFvIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULmJWcE9kSVE4Z25uYnkyWGhBbnVFdVNWQ3EzZ3VvalYzVlV2YllHNGRkS0kiLCJpc3MiOiJodHRwczovL2Rldi0zOTU3NTYub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNmYWZsbmVkaFNUU3A5WjBoNyIsImF1ZCI6IlBsYXRmb3JtIiwiaWF0IjoxNTUyOTAyNzQwLCJleHAiOjE1NTI5MDYzNDAsImNpZCI6IjBvYWpidmY3NDUyWW9VMzJFMGg3Iiwic2NwIjpbImFwaSJdLCJzdWIiOiIwb2FqYnZmNzQ1MllvVTMyRTBoNyJ9.Zwui0QdY2guaOTFzGD_zS28Iw8CRovAvVc3Sjcbt4nXmn1UGRhs3RrHf5-wu7kqK9S1r4YqO6M-OmMpkeiJxuipwFyjKTGEcxAMbFiuSNQpk2qpTc-WOV_-kwaUI3xF-kOu2ae1cby0UWX0KIe9OKr00wr5YCK1GP6tSzDjdaLaPrBgSbN1UnwMiFxlDNL9sCEWvYZUt4JK1Y-n_-j7heyzKG_G-0viCJHTtO2-bmKOlA_qV9S7xh37wJm_N6bx35WmPn3UKm4FRimHsHAgODvsfmLYjI8KCGpSY9JUcKWSw9wxiWdiY1ufmV_NebukJ7RlzwG8j1OAcI0kmoqIRkQ" \
  --request GET \
  --url ${proxy}/admin

curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --request GET \
  --url ${host}/apis

# Upgrade success to 0.14.x
export proxy=http://35.241.202.149
curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --header "Authorization: Bearer eyJraWQiOiJ2cXJUcUk0Y3BzUmN0Z2I1bW52QmxFdUpDVGlmcHM4VG1mcnUxdDJSLXFvIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULmRBcVQwSUVrTUtfUWh5eFI5TFhHNHpQaWVTYzNuaWVJVVRVRmVqd2c3elkiLCJpc3MiOiJodHRwczovL2Rldi0zOTU3NTYub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNmYWZsbmVkaFNUU3A5WjBoNyIsImF1ZCI6IlBsYXRmb3JtIiwiaWF0IjoxNTUyOTEzNzA1LCJleHAiOjE1NTI5MTczMDUsImNpZCI6IjBvYWpidmY3NDUyWW9VMzJFMGg3Iiwic2NwIjpbImFwaSJdLCJzdWIiOiIwb2FqYnZmNzQ1MllvVTMyRTBoNyJ9.bDbfG7xX1YjvrO9WJpC_FiT04EMLBenNbDqf00QV_tznSIuZ2Sa_I3t5X4zQMuPe5oI-rLpn5oKMh7Qmw14hZ_HgIzgyAKUwI3h4zyeKTx2jJpALj8gB3XzHsEo7zGua9KN3pYspsoi1N7iBFv6mulBvTqIQyljPzCSPSMH9AsVjn2n4k1ddFBRDcchDtmNgh991OeyKd6ci-0boXJj3f4Q_qYF9myMeW_lohWIgYftQtG8ynG1FGwOMr6leGbS1RrHPiJ6DpptVIWk5nHsFsDsl1ept1d4cUlmIqUaB12RfgPMnM-WEl2oaDN9VQakqA_-MSwIwm1fdJUkrgeqVnA" \
  --request GET \
  --url ${proxy}/admin

# Service ADMIN
curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --request POST \
  --data '{"name": "Admin-service", "url": "http://127.0.0.1:8444"}' \
  --url ${host}/services

# Route ADMIN "name": "Admin-route",
curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --request POST \
  --data '{"methods": ["GET", "POST", "PUT", "DELETE"],"protocols": ["http", "https"],"paths": ["/admin"]}' \
  --url ${host}/services/Admin-service/routes

# Get All Services
curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --request GET \
  --url ${host}/services

# Enable okta plugin
curl -X POST ${host}/services/Admin-service/plugins \
  --data "name=okta-auth" \
  --data "config.authorization_server=https://dev-395756.oktapreview.com/oauth2/ausfaflnedhSTSp9Z0h7" \
  --data "config.client_id=0oajbvf7452YoU32E0h7" \
  --data "config.client_secret=jPVHgU8HpNpha4JGCAjpO9HLj_59AtPZNiAUZ7Eh" \
  --data "config.api_version=v1" \
  --data "config.check_auth_server=true"

# Delete Api
curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --request DELETE \
  --url ${host}/apis/Api-Admin

# Proxy Admin interface
curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --header "Authorization: Bearer eyJraWQiOiJ2cXJUcUk0Y3BzUmN0Z2I1bW52QmxFdUpDVGlmcHM4VG1mcnUxdDJSLXFvIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnJKZlB2Y0lNVlNneWpYNDlFMi1TNzY1SXdNYUIzSVNmeE5Mc3Joc1I1bEkiLCJpc3MiOiJodHRwczovL2Rldi0zOTU3NTYub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNmYWZsbmVkaFNUU3A5WjBoNyIsImF1ZCI6IlBsYXRmb3JtIiwiaWF0IjoxNTUyOTYxMzM1LCJleHAiOjE1NTI5NjQ5MzUsImNpZCI6IjBvYWpidmY3NDUyWW9VMzJFMGg3Iiwic2NwIjpbImFwaSJdLCJzdWIiOiIwb2FqYnZmNzQ1MllvVTMyRTBoNyJ9.FPmKTbQhgadak0NYZGTW9_AFB0LfT3iUZz8rh1GLKdp_mzkj6uQ1URYq4YaCOcDy04r0HaBs2hGrqDcZMYRqz7EFb517JXR5gS1xgVQBaG1ZgaooanT3FLO5vpKusQ9uAoj_wGjyd7mGEjGQub-_kTezmirh4UOSB7t6WD7eFVagwrScY01s7vfPQabpgf2QKo2GKUJXkfhMC21yyQRRWSti0x1pPLx0ghb9v6-YnFnLe93fX4lA1L90POX4gTiWM0XfR1M-k4TJNxMkqxlWXimudqt7GHQSs4obIgHqXVkxXBWk9_cc9SBtyYjKJ6ttl4g_yPaIr-duSE0CkStxNg" \
  --request GET \
  --url ${proxy}/admin
