#!/bin/sh

# e = shell ecit if commands fails (output non zero exit status)
# x = printout command args during ex
# u = unset or undefined variables means errors - not applied for * or @
set -exu

imhere=$(pwd)
VIDEO_PATH="$(dirname "$imhere")"

## setup cluster with ingress addons
minikube start --memory 16384 --cpus 16 --kubernetes-version=v1.19.16 #--addons ingress
minikube addons enable ingress
minikube update-context

## install vp-cloud
cd ../../

kubectl config use-context minikube
kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission
helm install vp-cloud vp-cloud -f variants/default/values.cloud-particles.yaml --disable-openapi-validation --no-hooks
sleep 5
#kubectl get pod -n default -l app=videoserver-videomanagement -o jsonpath="{.items[*].status.conditions}" | jq

##TODO wait until later pods in ready
kubectl wait --for=condition=ready pod -l app=videoserver-videomanagement --timeout=10m

##TODO fill services

set +u
kubectl exec -it deployment/mongodb -- mongo -u "root" -p "toor" --authenticationDatabase "admin" -- video-server <<EOF
db.user.insert(
{
        "_id" : ObjectId("626ae81e9795d602627f3c9a"),
        "username" : "root",
        "password" : "$2a$10$Xl4JXy5Hq0dwszrDB7Lc5OyRTTrEueGVhO3gauui/OHKRN6dlxJ0q",
        "roles" : [
                "USER"
        ],
        "_class" : "com.arenalocastro.videomanagement.models.User"
})
db.createCollection('video')
db.video.insertMany([
{ "_id" : ObjectId("62656ddd71cd037a1e533c02"), "name" : "video_1649232691", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62657da171cd037a1e533c03"), "name" : "video_1650818465", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62657da271cd037a1e533c04"), "name" : "video_1650818466", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62657da371cd037a1e533c05"), "name" : "video_1650818467", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62657da471cd037a1e533c06"), "name" : "video_1650818467", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62657da471cd037a1e533c07"), "name" : "video_1650818468", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62657da571cd037a1e533c08"), "name" : "video_1650818469", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62657da671cd037a1e533c09"), "name" : "video_1650818470", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62657da771cd037a1e533c0a"), "name" : "video_1650818471", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62657da871cd037a1e533c0b"), "name" : "video_1650818471", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62657da871cd037a1e533c0c"), "name" : "video_1650818472", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" }])
EOF

ssh-keyscan $(minikube ip) >> ~/.ssh/known_hosts
minikube ssh "mkdir /home/docker/raw" </dev/null
minikube ssh "mkdir /home/docker/encoded" </dev/null
minikube ssh "sudo mkdir /var/cloud/videofiles/raw" </dev/null
minikube ssh "sudo mkdir /var/cloud/videofiles/encoded" </dev/null
scp -i $(minikube ssh-key) $VIDEO_PATH/raw.tar.gz docker@$(minikube ip):/home/docker/raw/raw.tar.gz
scp -i $(minikube ssh-key) $VIDEO_PATH/encoded.tar.gz docker@$(minikube ip):/home/docker/encoded/encoded.tar.gz

minikube ssh "sudo tar -xvf /home/docker/raw/raw.tar.gz -C /var/cloud/videos/. && rm -rf /home/docker/raw" </dev/null
minikube ssh "sudo tar -xvf /home/docker/encoded/encoded.tar.gz -C /var/cloud/videofiles/. && sudo mv /home/docker/encoded/encoded.tar.gz /var/cloud/videofiles/encoded" </dev/null
cd $imhere
while read -r video_id; do
   minikube ssh "sudo mkdir /var/cloud/videos/'$video_id' && cd /var/cloud/videos/'$video_id' && sudo ln -s ../video.mp4 ." </dev/null
   minikube ssh "sudo mkdir /var/cloud/videofiles/'$video_id' && cd /var/cloud/videofiles/'$video_id' && sudo ln -sf ../encoded/* . && sudo rm ./encoded.tar.gz" </dev/null
   minikube ssh "cd /var/cloud/videofiles && sudo ln -s ./encoded/encoded.tar.gz ./$video_id.tar" </dev/null
done < ./videolist.txt

## install && configure prometheus operatator
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts && helm repo update
kubectl create ns monitoring
#expose grafana
helm install kps-cloud prometheus-community/kube-prometheus-stack -n monitoring --set grafana.service.type=NodePort
kubectl patch service kps-cloud-grafana -n monitoring --type='json' --patch='[{"op": "replace", "path": "/spec/ports/0/nodePort", "value":30002}]'


##TODO not sure if needed when cleanup
##CRDs created by this chart are not removed by default and should be manually cleaned up:
#kubectl delete crd alertmanagerconfigs.monitoring.coreos.com
#kubectl delete crd alertmanagers.monitoring.coreos.com
#kubectl delete crd podmonitors.monitoring.coreos.com
#kubectl delete crd probes.monitoring.coreos.com
#kubectl delete crd prometheuses.monitoring.coreos.com
#kubectl delete crd prometheusrules.monitoring.coreos.com
#kubectl delete crd servicemonitors.monitoring.coreos.com
#kubectl delete crd thanosrulers.monitoring.coreos.com
