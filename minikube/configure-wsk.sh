#!/bin/bash
if ! which wsk &>/dev/null; then
    echo "please download and install OpenWhisk CLI first"
    exit 1
fi

wsk property set --apihost $(minikube ip):31001
wsk property set --auth 23bc46b1-71f6-4ed5-8c54-816aa4f8c502:123zO3xZCLrMN6v2BKK1dXYFpXlPkccOFqm12CdAsMgRU4VrNZ9lyGVCGuMDGIwP
