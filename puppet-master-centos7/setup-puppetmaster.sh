#!/usr/bin/env bash

# Source: https://www.howtoforge.com/tutorial/how-to-setup-puppet-master-and-agent-on-centos-7/

# check connection works
sudo -i
ping google.com -c 3
ping puppetmaster -c 3

sed -i '1s/^/172.31.0.201    Puppetmaster    puppetmaster\n172.31.0.202    Puppetagent     puppetagent\n/' /etc/hosts
# '/etc/hosts' should look something like this: (change ip and host names as required)
# 172.31.0.201    Puppetmaster    puppetmaster
# 172.31.0.202    Puppetagent     puppetagent

# ping puppetagent -c 3

# install some necessary packages
yum -y install ntp ntpdate vim
ntpdate 0.centos.pool.ntp.org
systemctl start ntpd
systemctl enable ntpd

# Disable SE Linux
vim /etc/sysconfig/selinux
sed -i 's\=enforcing\=disabled\g' /etc/sysconfig/selinux
# SELINUX=disabled

# install puppet agent & add puppet to
rpm -Uvh https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm
# reboot # can skip
yum -y install puppetserver
echo -e '\nexport PATH=/opt/puppetlabs/bin/:$PATH' >> ~/.bashrc
source ~/.bashrc
puppet --version

# configure puppet master
echo -e '[master]\n dns_alt_names = puppetmaster,puppet\n\n [main]\n certname = puppetmaster\n server = puppetmaster\n environment = production\n runinterval = 1h\n' > /etc/puppetlabs/puppet/puppet.conf

# '/etc/puppetlabs/puppet/puppet.conf' should look like:

# [master]
#  dns_alt_names=puppetmaster,puppet
#
# [main]
#  certname = puppetmaster
#  server = puppetmaster
#  environment = production
#  runinterval = 1h

systemctl start puppetserver
systemctl enable puppetserver