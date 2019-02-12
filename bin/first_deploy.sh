#!/usr/bin/env bash

set -e
# this script provisions and deploys the image to kubernetes

# pre-requisite setup (TODO: check that these are installed)
# create google account
# gcloud init (create project and setup credentials)
# gcloud components install kubectl

project_id='ai-sg-workshop'
version='some_version'
app_name='my-app'

gcloud auth configure-docker # need to run this if running this script locally. 

# provision cluster
gcloud container clusters create my-cluster --num-nodes=3 --region asia-southeast1

# build and publish docker image (based on whatever's in current source code)
docker build . -t asia.gcr.io/$project_id/$app_name:$version
docker push asia.gcr.io/$project_id/$app_name:$version

# test locally (optional)
# docker run -it --rm -p 8080:8080 asia.gcr.io/$project_id/my-app:$version
# curl localhost:8080

# deploy
kubectl run my-service --image=gcr.io/$project_id/$app_name:$version --port 8080
kubectl expose deployment my-service --type=LoadBalancer --port 80 --target-port 8080
# kubectl get service # run this to see the external IP after a while

