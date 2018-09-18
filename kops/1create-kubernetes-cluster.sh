export KOPS_STATE_STORE=s3://clusters.kubernetes.riotfork.com
export KOPS_CLUSTER_NAME=eu-central-1.kubernetes.riotfork.com

set -e
which aws
which kops
which kubectl
which helm

# create s3 bucket if it doesn't already exist
if ! aws s3 ls $KOPS_STATE_STORE &>/dev/null; then
    aws s3 mb s3://$KOPS_STATE_STORE
fi

# create IAM group and user for kops if necessary
if ! aws iam get-group --group-name kops &>/dev/null; then
    aws iam create-group --group-name kops

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess --group-name kops
    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonRoute53FullAccess --group-name kops
    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --group-name kops
    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/IAMFullAccess --group-name kops
    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonVPCFullAccess --group-name kops

    aws iam create-user --user-name kops

    aws iam add-user-to-group --user-name kops --group-name kops

    aws iam create-access-key --user-name kops
fi

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
    sleep 15
    echo -n "."
done
echo " done!"
