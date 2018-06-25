#!/bin/bash
helm install stable/traefik --namespace kube-system --name traefik -f values-traefik.yaml
kubectl create namespace monitoring
helm install stable/prometheus --namespace monitoring --name prometheus -f values-prometheus.yaml
helm install stable/grafana --namespace monitoring --name grafana -f values-grafana.yaml
