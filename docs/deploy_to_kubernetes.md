# Deploy on Kubernetes

This page demonstrates how you can deploy an app to Google Kubernetes Engine. To keep the demo simple, we will run this from our local machine. But it can also be run on any machine (e.g. CI), as long as the dependencies (e.g. `gcloud` and `kubectl`) and credentials (e.g. `GCLOUD_SERVICE_KEY`) are configured properly on your CI tool.

### Pre-requisites
- a dockerised application that works locally
- [Google Cloud Platform account](https://console.cloud.google.com)
- [`gcloud` cli](https://cloud.google.com/sdk/gcloud/)
- [`kubectl` cli](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

### Steps:

```shell
# build image:
# docker build . -t [GCP_DOCKER_REPOSITORY]/[YOUR_PROJECT]/[CONTAINER_NAME]:[version]
docker build . -t asia.gcr.io/ai-sg-workshop/my-app

# publish docker image
docker push asia.gcr.io/ai-sg-workshop/my-app

# [optional] test docker image locally
docker run -it --rm -p 8080:8080 asia.gcr.io/ai-sg-workshop/my-app
curl localhost:8080

# create kubernetes cluster
gcloud container clusters create my-cluster --region asia-southeast1

# Create deployment
kubectl apply -f bin/kubernetes/config/deployment.yml

# Expose deployment to the public (by using a load balancer service)
kubectl apply -f bin/kubernetes/config/service.yml

# To make any changes after deployment
kubectl apply -f bin/kubernetes/config/     # this applies the changes in any files the bin/kubernetes/config directory
```

Additional information:
- after creating your cluster, if you encounter issues authenticating / communicating with your cluster, you can get authentication credentials to interact with the cluster by running: `gcloud container clusters get-credentials my-cluster --region asia-southeast1`
