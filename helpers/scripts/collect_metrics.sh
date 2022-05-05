#!/bin/sh

set -exu
#default cluster
CLUSTER=cloud

#create snapshot
curl -XPOST http://$(minikube ip):30003/api/v1/admin/tsdb/snapshot

kubectl cp monitoring/prometheus-kps-"$CLUSTER"-kube-prometheus-prometheus-0:/prometheus/snapshots ./prom-data/
