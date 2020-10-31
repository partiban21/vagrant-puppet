#!/bin/bash
set -eu
echo "Configuring Puppet Agent"

# check connection works
#ping google.com -c 3

# add host info
sed -i '1s/^/192.168.33.10    puppetmaster\n192.168.33.11    puppetagentcentos\n/' /etc/hosts

#ping puppetmaster -c 3
#ping puppetagent -c 3

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
sudo yum install -y puppet-agent
#echo -e '\nexport PATH=/opt/puppetlabs/bin/:$PATH' >> ~/.bashrc
#source ~/.bashrc
/opt/puppetlabs/bin/puppet --version

# configure puppet agent
echo -e '\n[main]\n certname = puppetagentcentos\n server = puppetmaster\n environment = production\n runinterval = 1h\n' >> /etc/puppetlabs/puppet/puppet.conf

# '/etc/puppetlabs/puppet/puppet.conf' should look like:

#[main]
# certname = puppetagent
# server = puppetmaster
# environment = production
# runinterval = 1h

/opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true
