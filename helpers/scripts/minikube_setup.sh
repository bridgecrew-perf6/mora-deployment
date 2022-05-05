#!/bin/sh

# e = shell ecit if commands fails (output non zero exit status)
# x = printout command args during ex
# u = unset or undefined variables means errors - not applied for * or @
set -exu

## setup cluster with ingress addons
minikube start --memory 16384 --cpus 16 --kubernetes-version=v1.19.16 #--addons ingress
minikube addons enable ingress
minikube update-context
kubectl config use-context minikube
kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission

