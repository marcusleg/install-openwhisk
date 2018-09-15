#!/bin/bash
set -e

MINIKUBE_VERSION=$(minikube version | cut -d ' ' -f 3)
if [ $MINIKUBE_VERSION != v0.28.2 ]; then
    echo "This script was written for Minikube v0.28.2. Your version is $MINIKUBE_VERSION."
    read -p "Do you want to proceed? (y/n)" PROCEED
    if [ $PROCEED != 'y' ]; then
        exit
    fi
fi

minikube profile openwhisk
minikube config set cpus 4
minikube config set memory 4096
minikube start
minikube ssh -- sudo ip link set docker0 promisc on
minikube addons enable ingress
minikube addons enable metrics-server
