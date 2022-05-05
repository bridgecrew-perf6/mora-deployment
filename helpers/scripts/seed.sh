#!/bin/sh

# e = shell exit if commands fails (output non zero exit status)
# x = printout command args during ex
# u = unset or undefined variables means errors - not applied for * or @
set -ex
set +u

##to be sure longer deployment is up
kubectl wait --for=condition=ready pod -l app=videoserver-videomanagement --timeout=10m

VIDEOLIST_LOCATION=$(pwd)
#VIDEO_PATH=`find ~ -name "encoded.tar.gz" -printf '%h\n' 2>/dev/null`
VIDEO_PATH=`dirname $VIDEOLIST_LOCATION`

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
{ "_id" : ObjectId("62657da871cd037a1e533c0b"), "name" : "video_1650818473", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62657da871cd037a1e533c0c"), "name" : "video_1650818472", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("6272a26335487991895d4f44"), "name" : "video_1650818481", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("6272a26835487991895d4f45"), "name" : "video_1650818482", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("6272a26835487991895d4f46"), "name" : "video_1650818483", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("6272a26835487991895d4f47"), "name" : "video_1650818484", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("6272a26835487991895d4f48"), "name" : "video_1650818485", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("6272a26835487991895d4f49"), "name" : "video_1650818486", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("6272a28c35487991895d4f4a"), "name" : "video_1650818487", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("6272a2a035487991895d4f4b"), "name" : "video_1650818488", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("6272a2a035487991895d4f4c"), "name" : "video_1650818489", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("6272a2a035487991895d4f4d"), "name" : "video_1650818490", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afb5547717f70475865"), "name" : "video_1649232691", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f70475866"), "name" : "video_1650818465", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f70475867"), "name" : "video_1650818466", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f70475868"), "name" : "video_1650818467", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f70475869"), "name" : "video_1650818467", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f7047586a"), "name" : "video_1650818468", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f7047586b"), "name" : "video_1650818469", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f7047586c"), "name" : "video_1650818470", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f7047586d"), "name" : "video_1650818471", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f7047586e"), "name" : "video_1650818473", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f7047586f"), "name" : "video_1650818472", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f70475870"), "name" : "video_1650818481", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f70475871"), "name" : "video_1650818482", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f70475872"), "name" : "video_1650818483", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f70475873"), "name" : "video_1650818484", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f70475874"), "name" : "video_1650818485", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f70475875"), "name" : "video_1650818486", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f70475876"), "name" : "video_1650818487", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f70475877"), "name" : "video_1650818488", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f70475878"), "name" : "video_1650818489", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f70475879"), "name" : "video_1650818490", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f7047587a"), "name" : "video_1649232691", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f7047587b"), "name" : "video_1650818465", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f7047587c"), "name" : "video_1650818466", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f7047587d"), "name" : "video_1650818467", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f7047587e"), "name" : "video_1650818467", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f7047587f"), "name" : "video_1650818468", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f70475880"), "name" : "video_1650818469", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f70475881"), "name" : "video_1650818470", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f70475882"), "name" : "video_1650818471", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f70475883"), "name" : "video_1650818473", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f70475884"), "name" : "video_1650818472", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f70475885"), "name" : "video_1650818481", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f70475886"), "name" : "video_1650818482", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f70475887"), "name" : "video_1650818483", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f70475888"), "name" : "video_1650818484", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f70475889"), "name" : "video_1650818485", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f7047588a"), "name" : "video_1650818486", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f7047588b"), "name" : "video_1650818487", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f7047588c"), "name" : "video_1650818488", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f7047588d"), "name" : "video_1650818489", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f7047588e"), "name" : "video_1650818490", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f7047588f"), "name" : "video_1650818489", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" },
{ "_id" : ObjectId("62739afd5547717f70475890"), "name" : "video_1650818490", "author" : "root", "status" : "Available", "user" : ObjectId("626ae81e9795d602627f3c9a"), "_class" : "com.arenalocastro.videomanagement.models.Video" }])
EOF

ssh-keyscan $(minikube ip) >> ~/.ssh/known_hosts
minikube ssh "mkdir /home/docker/raw" </dev/null
minikube ssh "mkdir /home/docker/encoded" </dev/null
minikube ssh "sudo mkdir /var/cloud/videofiles/raw" </dev/null
minikube ssh "sudo mkdir /var/cloud/videofiles/encoded" </dev/null
scp -i $(minikube ssh-key) $VIDEO_PATH/raw.tar.gz docker@$(minikube ip):/home/docker/raw/raw.tar.gz
scp -i $(minikube ssh-key) $VIDEO_PATH/encoded.tar.gz docker@$(minikube ip):/home/docker/encoded/encoded.tar.gz
minikube ssh "gunzip /home/docker/encoded/encoded.tar.gz"
minikube ssh "sudo tar -xvf /home/docker/raw/raw.tar.gz -C /var/cloud/videos/. && rm -rf /home/docker/raw" </dev/null
minikube ssh "sudo tar -xvf /home/docker/encoded/encoded.tar -C /var/cloud/videofiles/. && sudo mv /home/docker/encoded/encoded.tar /var/cloud/videofiles" </dev/null

cd $VIDEOLIST_LOCATION

while read -r video_id; do
   minikube ssh "sudo mkdir /var/cloud/videos/'$video_id' && cd /var/cloud/videos/'$video_id' && sudo ln -s ../video.mp4 ." </dev/null
   minikube ssh "sudo mkdir /var/cloud/videofiles/'$video_id' && cd /var/cloud/videofiles/'$video_id' && sudo ln -sf ../encoded/* ." </dev/null
  # minikube ssh "cd /var/cloud/videofiles && sudo ln -s ./encoded/encoded.tar.gz ./$video_id.tar" </dev/null
   minikube ssh "cd /var/cloud/videofiles && sudo tar -cvf $video_id.tar -C encoded/ .  --transform='s|^|/$video_id/|'" < /dev/null
done < ./videolist.txt



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
