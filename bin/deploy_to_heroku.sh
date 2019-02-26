#!/bin/bash
set -e

heroku_app_name=$1
heroku_repo="https://heroku:$HEROKU_AUTH_TOKEN@git.heroku.com/$heroku_app_name.git"

echo "Deploying app to heroku..."
git push $heroku_repo master --force

echo "Running smoke test"
bin/predict.sh "$heroku_app_name.herokuapp.com"