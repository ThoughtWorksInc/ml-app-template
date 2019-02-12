#!/usr/bin/env bash

set -e

kubectl delete service my-app
gcloud container clusters delete my-cluster --region=asia-southeast1