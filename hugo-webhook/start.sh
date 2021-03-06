#!/bin/sh

sed -i -e "s/\$GITHUB_USERNAME/$GITHUB_USERNAME/" hugo-update.yaml
sed -i -e "s/\$GITHUB_PASSWD/$GITHUB_PASSWD/" hugo-update.yaml

kubectl get job hugo-update && kubectl delete job hugo-update
kubectl apply -f hugo-update.yaml