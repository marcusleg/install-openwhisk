#!/bin/bash
set -e

minikube profile openwhisk
minikube config set cpus 4
minikube config set memory 4096
minikube start --extra-config=apiserver.Authorization.Mode=RBAC
minikube ssh -- sudo ip link set docker0 promisc on
minikube addons enable metrics-server
