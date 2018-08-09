# install-openwhisk
This repository holds the installations scripts for the OpenWhisk test environemnts I used while writing my bachelor's thesis.  
The two environments are:

* A Kubernetes cluster running on AWS. (Installed and maintained using [kops](https://github.com/kubernetes/kops).)
* A [Minikube](https://github.com/kubernetes/minikube) Kubernetes cluster

Maintenance is likely to end after August 27th, 2018.


## How to use
Navigate to either the kops/ or minikube/ subfolder and run the numbered Bash scripts in ascending order.  
**Warning:** the kops installation has a lot of hardcoded configuration specific to my AWS account!


## Note on publishing
At the time of writing this is a private repository. It will not be made public before August 27th, 2018.
