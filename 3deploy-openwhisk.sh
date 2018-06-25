#!/bin/bash
kubectl create namespace openwhisk

cd /tmp
rm -rf incubator-openwhisk-deploy-kube/
git clone https://github.com/apache/incubator-openwhisk-deploy-kube
cd incubator-openwhisk-deploy-kube/helm/
kubectl label nodes $(kubectl get nodes | grep node | cut -d " " -f 1) openwhisk-role=invoker

kubectl -n openwhisk apply -f openwhisk-ingress.yaml
