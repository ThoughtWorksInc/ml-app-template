#!/bin/bash
set -e

gcp_project_id='ai-sg-workshop'
image_name='ci-workshop-app'
region='asia-southeast1'
cluster_name='app-cluster'

# build image
docker build . -t asia.gcr.io/$gcp_project_id/$image_name --target Build

# publish docker image
docker push asia.gcr.io/$gcp_project_id/$image_name

# provision kubernetes cluster if not yet created
gcloud container clusters describe $cluster_name --region $region || gcloud container clusters create $cluster_name --region $region

# creating the deployment
kubectl apply -f bin/kubernetes/config/deployment.yml

# create a load-balancer service to expose our deployment
kubectl apply -f bin/kubernetes/config/service.yml
