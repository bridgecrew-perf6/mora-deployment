#!/bin/sh

#get gitlab-repo
curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.rpm.sh" | sudo bash

#update repo and install gitlab
sudo yum update && sudo yum install gitlab-runner

# add gitlab-runner to sudoers
echo 'gitlab-runner ALL=(ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers
