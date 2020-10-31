#!/bin/bash
set -eu
echo "Configuring Puppet Master"

# check connection works
#ping google.com -c 3

# add host info
sed -i '1s/^/192.168.33.10    puppetmaster\n192.168.33.11    puppetagentcentos\n192.168.33.12    puppetagentubuntu\n/' /etc/hosts

#ping puppetmaster -c 3

# install some necessary packages
sudo yum -y install ntp ntpdate vim
sudo ntpdate 0.centos.pool.ntp.org
#sudo ntpdate ntp.prd.ace
sudo systemctl start ntpd
sudo systemctl enable ntpd

# disable SE Linux
sed -i 's\=enforcing\=disabled\g' /etc/sysconfig/selinux

# install puppet agent & add puppet to
rpm -Uvh https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm
#reboot # can skip
sudo yum install -y puppetserver
sed -i 's\-Xms2g -Xmx2g\-Xms1g -Xmx1g\g' /etc/sysconfig/puppetserver
#echo -e '\nexport PATH=/opt/puppetlabs/bin/:$PATH' >> ~/.bashrc
#source ~/.bashrc
/opt/puppetlabs/bin/puppet --version

# configure puppet master
echo -e '[master]\n dns_alt_names = puppetmaster,puppet\n\n [main]\n certname = puppetmaster\n server = puppetmaster\n environment = production\n runinterval = 1h\n' > /etc/puppetlabs/puppet/puppet.conf

systemctl start puppetserver
systemctl enable puppetserver
