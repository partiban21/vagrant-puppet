#!/usr/bin/env bash
set -e

#Install vagrant ssh key
mkdir /home/vagrant/.ssh
# This insecure key is overwritten by a secured key by vagrant when `vagrant up` is done
wget --no-check-certificate -O authorized_keys 'https://github.com/mitchellh/vagrant/raw/master/keys/vagrant.pub'
mv authorized_keys /home/vagrant/.ssh
chown -R vagrant /home/vagrant/.ssh
chmod -R go-rwsx /home/vagrant/.ssh
