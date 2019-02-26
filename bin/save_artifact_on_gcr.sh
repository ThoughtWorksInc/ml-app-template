#!/bin/bash
set -e

GOOGLE_PROJECT_ID='ai-sg-workshop'
GOOGLE_COMPUTE_ZONE='asia-southeast1-a'
IMAGE_NAME='ci-workshop-app'

docker tag ci-workshop-app:build asia.gcr.io/$GOOGLE_PROJECT_ID/$IMAGE_NAME:$CIRCLE_SHA1
docker push asia.gcr.io/$GOOGLE_PROJECT_ID/$IMAGE_NAME:$CIRCLE_SHA1
