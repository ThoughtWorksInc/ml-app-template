#!/usr/bin/env bash
set -e

heroku_app_name=$1
container_name='david-docker-staging'

curl -n -X PATCH https://pi.heroku.com/apps/$heroku_app_name/formation \
  -H "Content-Type: application/json" \
  -H "Accept: application/vnd.heroku+json; version=3.docker-releases" \
  --data @<(cat <<EOF
{
  "updates": [
    {
      "type": "web",
      "docker_image": "registry.heroku.com/$container_name/web"
    },
  ]
}
EOF
)
  -d '' \