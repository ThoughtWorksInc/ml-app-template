#!/usr/bin/env bash
set -e

if [[ $1 == '' ]]; then
  echo "[ERROR] Usage  : $0 <image-tag>"
  echo "[ERROR] Example: $0 f89s0asd)"
  echo "[ERROR] Exiting..."
  exit 1
fi

image_tag=$1
gcp_project_id='ai-sg-workshop'
image_name='ci-workshop-app'
deployment_name='ci-workshop-app-deployment'

# build image
if [[ $CI != 'true' ]]; then
  # skip this on CI
  docker build . -t asia.gcr.io/$gcp_project_id/$image_name:$image_tag --target Base
fi

# publish docker image
docker push asia.gcr.io/$gcp_project_id/$image_name:$image_tag

kubectl set image deployment/$deployment_name $image_name=asia.gcr.io/$gcp_project_id/$image_name:$image_tag