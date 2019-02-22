#!/usr/bin/env bash
set -e

gcp_project_id='ai-sg-workshop'
image_name='ci-workshop-app'
deployment_name='ci-workshop-app-deployment'
container_name='ci-workshop-app'

# build image
docker build . -t asia.gcr.io/$gcp_project_id/$image_name --target Base

# publish docker image
docker push asia.gcr.io/$gcp_project_id/$image_name

kubectl set image deployment/$deployment_name $container_name=asia.gcr.io/$gcp_project_id/$container_name