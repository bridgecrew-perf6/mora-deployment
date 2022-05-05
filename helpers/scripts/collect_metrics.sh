#!/bin/sh

set -exu
#create snapshot
curl -XPOST http://$(minikube ip):30003/api/v1/admin/tsdb/snapshot
kubectl cp monitoring/$(kubectl get pods --all-namespaces|grep prometheus-kps|awk '{print $2}'):/prometheus/snapshots ./prom-data/$(date +%s)
