#!/usr/bin/env bash
set -e

# docs: https://cloud.google.com/container-registry/docs/using-with-google-cloud-platform#deploying_to

# if you're deploying this app for the first time, these need to be run manually because there will be interactive steps
image_version=$CIRCLE_SHA1

docker build . -t asia.gcr.io/ai-sg-workshop/my-app:$image_version
docker push asia.gcr.io/ai-sg-workshop/my-app:$image_version
gcloud app deploy --image-url=asia.gcr.io/ai-sg-workshop/my-app:$image_version