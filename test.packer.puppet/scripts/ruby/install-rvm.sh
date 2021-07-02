#!/bin/bash
set -eu

# Install the packages required for RVM and Ruby
sudo yum install -y --setopt=skip_missing_names_on_install=False \
gcc-c++ \
patch \
readline \
readline-devel \
zlib zlib-devel \
libffi-devel \
openssl-devel \
make \
bzip2 \
autoconf \
automake \
libtool \
bison \
sqlite-devel \
ruby

# RVM 
curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -

curl -L get.rvm.io | bash -s stable
source /etc/profile.d/rvm.sh
# export PATH=/usr/local/rvm/bin/:$PATH # rvm: command not found, because needs terminal needs reloads
/usr/local/rvm/bin/rvm reload
/usr/local/rvm/bin/rvm requirements run

# ruby 
/usr/local/rvm/bin/rvm install 2.3
# /usr/local/rvm/bin/rvm use --default 2.3

# gems
# gem install r10k
