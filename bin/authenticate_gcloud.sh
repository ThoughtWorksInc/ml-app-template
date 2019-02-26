#!/bin/bash
set -e

GOOGLE_PROJECT_ID='ai-sg-workshop'
GOOGLE_COMPUTE_ZONE='asia-southeast1-a'

echo $GCLOUD_SERVICE_KEY | gcloud auth activate-service-account --key-file=-
gcloud --quiet config set project $GOOGLE_PROJECT_ID
gcloud --quiet config set compute/zone $GOOGLE_COMPUTE_ZONE
gcloud auth configure-docker
