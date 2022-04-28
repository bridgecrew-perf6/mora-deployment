#!/bin/sh

# e = shell ecit if commands fails (output non zero exit status)
# x = printout command args during ex
# u = unset or undefined variables means errors - not applied for * or @
set -exu

imhere = $(pwd)

## setup cluster with ingress addons
minikube start --memory 16384 --cpus 16 --kubernetes-version=v1.19.16 --addons ingress
minikube update-context

## install vp-cloud
cd ../../
helm install vp-cloud vp-cloud -f variants/custom/values.cloud-particles.yaml --disable-openapi-validation
#kubectl get pod -n default -l app=videoserver-videomanagement -o jsonpath="{.items[*].status.conditions}" | jq
kubectl wait --for=condition=ready pod -l app=videoserver-videomanagement

##TODO feel services


cd imhere
## install && configure prometheus operatator
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts && helm repo update
kubectl create ns monitoring
#expose grafana
helm install kps-cloud prometheus-community/kube-prometheus-stack -n monitoring --set grafana.service.type=NodePort
kubectl patch service kps-test-grafana -n monitoring2 --type='json' --patch='[{"op": "replace", "path": "/spec/ports/0/nodePort", "value":30002}]'


##todo not sure if needed
##CRDs created by this chart are not removed by default and should be manually cleaned up:
#kubectl delete crd alertmanagerconfigs.monitoring.coreos.com
#kubectl delete crd alertmanagers.monitoring.coreos.com
#kubectl delete crd podmonitors.monitoring.coreos.com
#kubectl delete crd probes.monitoring.coreos.com
#kubectl delete crd prometheuses.monitoring.coreos.com
#kubectl delete crd prometheusrules.monitoring.coreos.com
#kubectl delete crd servicemonitors.monitoring.coreos.com
#kubectl delete crd thanosrulers.monitoring.coreos.com