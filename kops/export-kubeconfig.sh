#!/bin/bash
export KOPS_STATE_STORE=s3://clusters.kubernetes.riotfork.com
kops export kubecfg
