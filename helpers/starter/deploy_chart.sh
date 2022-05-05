#!/bin/sh

# e = shell exit if commands fails (output non zero exit status)
# x = printout command args during ex
# u = unset or undefined variables means errors - not applied for * or @
set -exu

##TODO fix relative path
## install vp-cloud
cd ../../
helm install vp-cloud vp-cloud -f variants/default/values.cloud-particles.yaml --disable-openapi-validation --no-hooks
sleep 5
##TODO wait until later pods in ready
kubectl wait --for=condition=ready pod -l app=videoserver-videomanagement --timeout=10m


