#!/bin/bash
set -e

minikube profile openwhisk
minikube config set kubernetes-version v1.9.0
minikube config set cpus 4
minikube config set memory 4096
minikube config set WantUpdateNotification false
minikube start --extra-config=apiserver.Authorization.Mode=RBAC
minikube ssh -- sudo ip link set docker0 promisc on
