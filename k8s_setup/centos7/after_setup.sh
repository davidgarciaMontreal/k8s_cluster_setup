#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail
set -o errtrace
kubectl create -f private-registry.yaml
kubectl get deployments private-repository-k8s
kubectl get pods | grep -i  private-repo
kubectl create -f private-registry-svc.yaml
kubectl get svc private-repository-k8s
