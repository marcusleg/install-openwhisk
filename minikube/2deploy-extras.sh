#!/bin/bash
# install helm
helm init
echo -n "Waiting for tiller pod to start"
while ! kubectl get pod -n kube-system | grep tiller | grep "Running" &>/dev/null; do
    echo -n "."
    sleep 5
done
echo "done!"
kubectl create clusterrolebinding tiller-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:default

# install monitoring components
kubectl create namespace monitoring
helm install stable/prometheus --namespace monitoring --name prometheus -f values-prometheus.yaml
helm install stable/grafana --namespace monitoring --name grafana

