#!/bin/bash
set -e

MINIKUBE_VERSION=$(minikube version | cut -d ' ' -f 3)
if [ $MINIKUBE_VERSION != v0.28.2 ]; then
    echo "This script was written for Minikube v0.28.2. Your version is $MINIKUBE_VERSION."
    read -p "Do you want to proceed? (y/n) " -n 1 -r
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo ""
        exit 0
    fi
fi

minikube profile openwhisk

if minikube status &>/dev/null; then
    echo 'Minikube already running. Type "minikube stop" to spot it.'
    exit 1
fi

if [[ -d ~/.minikube/machines/openwhisk/ ]]; then
    echo 'Starting existing Minikube VM'
    minikube start
else
    echo 'Setting up new Minikube VM'
    minikube config set cpus 4
    minikube config set memory 4096
    minikube start
    minikube ssh -- sudo ip link set docker0 promisc on
    minikube addons enable ingress
    minikube addons enable metrics-server
fi
