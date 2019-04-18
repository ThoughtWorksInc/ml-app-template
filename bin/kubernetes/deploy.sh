#!/bin/bash
set -ex

GOOGLE_PROJECT_ID='ai-sg-workshop'
GOOGLE_COMPUTE_REGION='asia-southeast1'
IMAGE_NAME='ml-app-template'
DEPLOYMENT_NAME='ml-app-template-deployment'
CLUSTER_NAME='app-cluster'

# authenticate the agent running this command (depends on GCLOUD_SERVICE_KEY environment variable to be set)
gcloud container clusters get-credentials $CLUSTER_NAME --region $GOOGLE_COMPUTE_REGION

# deploy new image
kubectl set image deployment/$DEPLOYMENT_NAME $IMAGE_NAME=asia.gcr.io/$GOOGLE_PROJECT_ID/$IMAGE_NAME:$CIRCLE_SHA1
