#!/bin/bash
set -eu

# Install the packages required for Virtualbox guest additions
yum install -y --setopt=skip_missing_names_on_install=False \
	       wget \
	       bzip2 \
	       tar \
	       make \
	       gcc \
	       gcc-c++ \
	       "kernel-devel-$(uname -r)" \
	       "kernel-headers-$(uname -r)" \
	       python3 \
	       python3-pip

pip3 install pytest pytest-helpers-namespace

mkdir /tmp/virtualbox
VERSION=$(cat /home/vagrant/.vbox_version)
mount -o loop "/home/vagrant/VBoxGuestAdditions_${VERSION}.iso" /tmp/virtualbox
sh /tmp/virtualbox/VBoxLinuxAdditions.run
umount /tmp/virtualbox
rmdir /tmp/virtualbox
rm /home/vagrant/*.iso

yum update -y
