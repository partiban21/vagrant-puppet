#!/bin/bash
set -eu

# determine unix platform (CentOS or Ubuntu)

platfom=$( awk -F= '/^NAME/{print $2}' /etc/os-release )

echo $platfom

# install docker

sudo yum install -y yum-utils

sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
	
sudo yum -y install docker-ce docker-ce-cli containerd.io

sudo systemctl start docker

sudo groupadd docker || true

sudo usermod -aG docker $USER

# Log out and log back in so that your group membership is re-evaluated.
# `exec su -l $USER`
su -l $USER <<!
vagrant
exec
!

docker run hello-world

docker pull centos:centos8
