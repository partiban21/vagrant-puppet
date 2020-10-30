#!/bin/bash
set -eu
echo "Configuring Puppet Agent"

sudo apt-get update -y
# check connection works
#ping google.com -c 3

# add host info
sed -i '1s/^/192.168.33.10    puppetmaster\n192.168.33.12    puppetagentubuntu\n/' /etc/hosts

#ping puppetmaster -c 3
#ping puppetagent -c 3

# install puppet agent & add puppet to
wget https://apt.puppetlabs.com/puppet5-release-bionic.deb
#reboot # can skip
sudo dpkg -i puppet5-release-bionic.deb
sudo apt-get update -y
#sudo apt-get install puppetserver -y
sudo apt-get install puppet-agent -y
#echo -e '\nexport PATH=/opt/puppetlabs/bin/:$PATH' >> ~/.bashrc
#source ~/.bashrc
/opt/puppetlabs/bin/puppet --version

# configure puppet agent
echo -e '\n[main]\n certname = puppetagentubuntu\n server = puppetmaster\n environment = ubuntuenv\n runinterval = 1h\n' >> /etc/puppetlabs/puppet/puppet.conf

# '/etc/puppetlabs/puppet/puppet.conf' should look like:

#[main]
# certname = puppetagent
# server = puppetmaster
# environment = production
# runinterval = 1h

sudo systemctl start puppet
sudo systemctl enable puppet
sudo systemctl status puppet
