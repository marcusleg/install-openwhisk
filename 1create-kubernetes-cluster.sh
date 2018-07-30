export KOPS_STATE_STORE=s3://clusters.kubernetes.riotfork.com
export KOPS_CLUSTER_NAME=eu-central-1.kubernetes.riotfork.com

set -e
which aws
which kops
which kubectl
which helm

# create s3 bucket if it doesn't already exist
aws s3 mb $KOPS_STATE_STORE || true

# create cluster config
kops create cluster \
--master-zones=eu-central-1a \
--zones=eu-central-1a \
--master-size=m3.medium --node-size=t2.medium --node-count=2 \
--master-volume-size=16 --node-volume-size=32 \
--dns-zone=riotfork.com

# start the cluster
kops update cluster --yes

echo -n "Waiting for Cluster to come up"
while ! kops validate cluster &>/dev/null; do
    sleep 10
    echo -n "."
done
echo " done!"
