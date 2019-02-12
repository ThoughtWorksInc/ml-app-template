#!/usr/bin/env bash

set -e

# subsequent deploys
# kubectl patch deployment ai-sg-workshop-app -p '{"spec":{"template":{"spec":{"containers":[{"name":"ai-sg-workshop-app","image":"asia.gcr.io/ai-sg-workshop/my-app"}]}}}}'

# set specific image
new_version='some_new_version'
# docker build ......
# docker push asia.gcr.io/$project_id/my-app:$new_version
# kubectl set image deployment/my-app my-app=asia.gcr.io/$project_id/my-app:$new_version