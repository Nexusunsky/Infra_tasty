#!/usr/bin/env bash

password: rwIf1xgen5accG40

# 1 Install Git
# 2 Git Clone https://github.com/techops-infradel/kong-okta-auth-plugin.git
# cp dir
# Restart kong and enable plugin.

apk add --update \
    curl \
    && rm -rf /var/cache/apk/*

export admin="130.211.99.250:8444"
export proxy="35.241.202.149:8443"

# Kong Admin
curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --request GET \
  --url ${admin}/

# Api ADMIN
curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --request POST \
  --data '{"name": "Api-Admin", "upstream_url": "http://127.0.0.1:8444", "uris": "/admin"}' \
  --url ${admin}/apis

# Enable okta plugin
curl -X POST ${admin}/apis/Api-Admin/plugins \
  --data "name=okta-auth" \
  --data "config.authorization_server=https://dev-395756.oktapreview.com/oauth2/ausfaflnedhSTSp9Z0h7" \
  --data "config.client_id=0oajbvf7452YoU32E0h7" \
  --data "config.client_secret=jPVHgU8HpNpha4JGCAjpO9HLj_59AtPZNiAUZ7Eh" \
  --data "config.api_version=v1" \
  --data "config.check_auth_server=true"

# Admin interface
curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --header "Authorization: Bearer eyJraWQiOiJ2cXJUcUk0Y3BzUmN0Z2I1bW52QmxFdUpDVGlmcHM4VG1mcnUxdDJSLXFvIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULmIwYXg2WUwwWHVDY1JXR3lMS0FjQmVvSlhEVFpTQjZCUUhsYlBJWEVGd00iLCJpc3MiOiJodHRwczovL2Rldi0zOTU3NTYub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNmYWZsbmVkaFNUU3A5WjBoNyIsImF1ZCI6IlBsYXRmb3JtIiwiaWF0IjoxNTUyOTg4ODQ3LCJleHAiOjE1NTI5OTI0NDcsImNpZCI6IjBvYWpidmY3NDUyWW9VMzJFMGg3Iiwic2NwIjpbImFwaSJdLCJzdWIiOiIwb2FqYnZmNzQ1MllvVTMyRTBoNyJ9.JFLyfsjyjYYMd6Pqjp9-EblHDL5s9hIcWNzNiLuwxIvtMmbOG6UCH2uD9hszyMUVuzDx9zj1_iaW_9vlRdQwN-APV_NdStrlMVXtOL-xOgbAwC6hlEG55PLCTVDa9gjEckcOkcJuT8y_IKN08tRHXEV4Kamxo4WXXz-iofP4x_MhJaiHKjmf6Kq_v2GDNep19JAuLMNTPYd0F6OAyV3ksSXFKGqe7dChy2VZp9OrJeR97M9iRLJyXxQmjwjHYzQtjwAGN0e94cV3Q-WCORVSLhUeI2X6NXcFzPdcnCU1d-tRNcNd8WFeN0Sr8AN7S_qIfhwvQ_flDT84c4Tf1Lku1g" \
  --request GET \
  --url ${proxy}/admin

curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --request GET \
  --url ${admin}/apis

# Enable okta plugin for terminate all request for upgrade
curl -i -X POST ${admin}/plugins \
  --data "name=request-termination"
# Disable
curl -i -X DELETE ${admin}/plugins/161003c0-04ff-4f3b-9523-7bc239afd982


# Upgrade success to 0.14.x
export proxy=http://35.241.141.241
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
  --url ${admin}/services

# Route ADMIN "name": "Admin-route",
curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --request POST \
  --data '{"methods": ["GET", "POST", "PUT", "DELETE"],"protocols": ["http", "https"],"paths": ["/admin"]}' \
  --url ${admin}/services/Admin-service/routes

# Get All Services
curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --request GET \
  --url ${admin}/services

# Enable okta plugin
curl -X POST ${admin}/services/Admin-service/plugins \
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
  --url ${admin}/apis/Api-Admin

# Proxy Admin interface
curl -i \
  --header "Content-Type: application/json;charset=UTF-8" \
  --header "Authorization: Bearer eyJraWQiOiJ2cXJUcUk0Y3BzUmN0Z2I1bW52QmxFdUpDVGlmcHM4VG1mcnUxdDJSLXFvIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnJKZlB2Y0lNVlNneWpYNDlFMi1TNzY1SXdNYUIzSVNmeE5Mc3Joc1I1bEkiLCJpc3MiOiJodHRwczovL2Rldi0zOTU3NTYub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNmYWZsbmVkaFNUU3A5WjBoNyIsImF1ZCI6IlBsYXRmb3JtIiwiaWF0IjoxNTUyOTYxMzM1LCJleHAiOjE1NTI5NjQ5MzUsImNpZCI6IjBvYWpidmY3NDUyWW9VMzJFMGg3Iiwic2NwIjpbImFwaSJdLCJzdWIiOiIwb2FqYnZmNzQ1MllvVTMyRTBoNyJ9.FPmKTbQhgadak0NYZGTW9_AFB0LfT3iUZz8rh1GLKdp_mzkj6uQ1URYq4YaCOcDy04r0HaBs2hGrqDcZMYRqz7EFb517JXR5gS1xgVQBaG1ZgaooanT3FLO5vpKusQ9uAoj_wGjyd7mGEjGQub-_kTezmirh4UOSB7t6WD7eFVagwrScY01s7vfPQabpgf2QKo2GKUJXkfhMC21yyQRRWSti0x1pPLx0ghb9v6-YnFnLe93fX4lA1L90POX4gTiWM0XfR1M-k4TJNxMkqxlWXimudqt7GHQSs4obIgHqXVkxXBWk9_cc9SBtyYjKJ6ttl4g_yPaIr-duSE0CkStxNg" \
  --request GET \
  --url ${proxy}/admin
