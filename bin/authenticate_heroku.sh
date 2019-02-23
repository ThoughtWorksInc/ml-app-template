#!/usr/bin/env bash
set -e

HEROKU_AUTH_TOKEN=$1

IFS=''
echo 'machine api.heroku.com' >> .netrc
echo '  login davified@gmail.com' >> .netrc
echo "  password $HEROKU_AUTH_TOKEN" >> .netrc
  
  
