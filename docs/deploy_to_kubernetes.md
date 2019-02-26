# Deploy on Kubernetes

This page demonstrates how you can deploy an app to Google Kubernetes Engine. To keep the demo simple, we will run this from our local machine. But it can also be run on any machine (e.g. CI), as long as the dependencies (e.g. `gcloud` and `kubectl`) and credentials (e.g. `GCLOUD_SERVICE_KEY`) are configured properly on your CI tool.

### Pre-requisites
- a dockerised application that works locally
- [Google Cloud Platform account](https://console.cloud.google.com)
- [`gcloud` cli](https://cloud.google.com/sdk/gcloud/)
- [`kubectl` cli](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

### Steps:

```shell
# 1. Provision kubernetes cluster
bin/kubernetes/provision.sh

# 2. Get external ip address for your kubernetes cluster 
# (you have to wait take a few minutes if you're running provision.sh for the first time)
kubectl get services

# 3. Test your app - Copy and paste the external ip from the previous command in the browser or REST client

# 4. To deploy a new version of the app, CI will call the following script
bin/kubernetes/deploy.sh
# You can refer to .circleci/config.kubernetes.reference.yaml to see the CI pipeline
```

Other commands:

```shell
# [optional] test docker image locally (use gcp_project_id and image_name as defined in provision.sh)
docker run -it --rm -p 8080:8080 asia.gcr.io/$gcp_project_id/$image_name
curl localhost:8080

# If To make any changes after deployment
kubectl apply -f bin/kubernetes/config/     # this applies the changes in any files the bin/kubernetes/config directory

# After creating your cluster, if you encounter issues authenticating / communicating with your cluster, you can get authentication credentials to interact with the cluster by running:
gcloud container clusters get-credentials my-cluster --region asia-southeast1

```

Further reading:
- https://cloud.google.com/kubernetes-engine/docs/quickstart
- https://cloud.google.com/kubernetes-engine/docs/tutorials/hello-app
- https://cloud.google.com/kubernetes-engine/docs/how-to/stateless-apps
