#!/bin/bash
minikube profile openwhisk

if minikube status &>/dev/null; then
    minikube stop
fi
minikube delete
