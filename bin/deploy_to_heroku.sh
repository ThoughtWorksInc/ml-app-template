#!/usr/bin/env bash
set -e

heroku_app_name=$1
heroku_repo="https://heroku:$HEROKU_AUTH_TOKEN@git.heroku.com/$heroku_app_name.git"

git push $heroku_repo master

echo "Running smoke test"
bin/predict.sh "$heroku_app_name.herokuapp.com"