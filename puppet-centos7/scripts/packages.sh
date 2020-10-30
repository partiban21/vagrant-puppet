#!/bin/bash

sudo yum install -y tree gcc-c++ patch readline readline-devel zlib zlib-devel libffi-devel \
openssl-devel make bzip2 autoconf automake libtool bison sqlite-devel


# RVM 
curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -

curl -L get.rvm.io | bash -s stable
source /etc/profile.d/rvm.sh
rvm reload
rvm requirements run

# ruby 
rvm install 2.3
rvm use 2.3 --default

# gems
gem install r10k

# compliance 
sudo cp /vagrant/compliance-suite-0.8.2/* /etc/puppetlabs/code/environments/production/ -r
pushd /etc/puppetlabs/code/environments/production/
r10k puppetfile install
popd
