#!/bin/bash
kubectl label nodes $(kubectl get nodes | grep node | cut -d " " -f 1) openwhisk-role=invoker
kubectl create namespace openwhisk
helm install incubator-openwhisk-deploy-kube/helm/ --namespace openwhisk --name openwhisk -f values-openwhisk.yaml
kubectl -n openwhisk apply -f openwhisk-ingress.yaml
