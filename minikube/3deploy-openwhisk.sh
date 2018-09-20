#!/bin/bash
kubectl label nodes --all openwhisk-role=invoker
kubectl create namespace openwhisk
helm install ../incubator-openwhisk-deploy-kube/helm/openwhisk/ --namespace openwhisk --name openwhisk -f values-openwhisk.yaml --set whisk.ingress.api_host_name=$(minikube ip)
