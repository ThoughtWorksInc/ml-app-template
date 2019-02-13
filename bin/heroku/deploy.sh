#!/usr/bin/env bash
set -e

heroku_app_name=$1
heroku_repo="https://heroku:$HEROKU_APP_KEY@git.heroku.com/$heroku_app_name.git"

git push $heroku_repo master