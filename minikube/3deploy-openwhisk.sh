#!/bin/bash
kubectl label nodes minikube openwhisk-role=invoker
kubectl create namespace openwhisk
helm install ../incubator-openwhisk-deploy-kube/helm/openwhisk/ --namespace openwhisk --name openwhisk -f values-openwhisk.yaml
