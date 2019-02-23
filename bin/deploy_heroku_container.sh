#!/usr/bin/env bash
set -e

HEROKU_APP_NAME=$1

curl -n -X PATCH https://api.heroku.com/apps/$HEROKU_APP_NAME/formation \
  -d '{
  "updates": [
    {
      "type": "web",
      "docker_image": "registry.heroku.com/david-docker-staging/web"
    },
  ]
}' \
  -H "Content-Type: application/json" \
  -H "Accept: application/vnd.heroku+json; version=3.docker-releases"