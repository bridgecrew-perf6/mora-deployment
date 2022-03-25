#!/bin/bash

function change_dir() {
  cd "$1" || exit
}

START_PATH=$(pwd)

change_dir ../../videomanagement
docker build -t massigollo/video-server:cloud-vms --no-cache -f Dockerfile.production .

change_dir "$START_PATH"
change_dir ../../videoprocessing
docker build -t massigollo/video-server:cloud-vps --no-cache -f Dockerfile .

change_dir "$START_PATH/gateway"
docker build -t massigollo/video-server:cloud-gateway --no-cache -f Dockerfile .

docker push massigollo/video-server:cloud-vms
docker push massigollo/video-server:cloud-vps
docker push massigollo/video-server:cloud-gateway


