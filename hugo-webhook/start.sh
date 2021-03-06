#!/bin/sh

kubectl get job hugo-update && kubectl delete job hugo-update
kubectl apply -f hugo-update.yaml