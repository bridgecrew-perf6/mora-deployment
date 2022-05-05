#!/bin/sh

set -exu
#create snapshot
curl -XPOST http://$(minikube ip):30003/api/v1/admin/tsdb/snapshot

kubectl cp monitoring/prometheus-kps-"$1"-kube-prometheus-prometheus-0:/prometheus/snapshots ./prom-data/$(date +%s)
