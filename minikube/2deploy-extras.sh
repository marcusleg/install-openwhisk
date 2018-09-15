#!/bin/bash
# install helm
helm init --wait
kubectl create clusterrolebinding tiller-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:default

# install monitoring components
kubectl create namespace monitoring
helm install stable/prometheus --namespace monitoring --name prometheus -f values-prometheus.yaml --set server.ingress.hosts={prometheus.$(minikube ip).xip.io}
helm install stable/grafana --namespace monitoring --name grafana -f values-grafana.yaml --set ingress.hosts={grafana.$(minikube ip).xip.io}

