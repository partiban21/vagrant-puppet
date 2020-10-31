test.packer.puppet
==================

This repository is used to create vagrant boxes using packer that have a working version of 
Puppet installed (Puppet 5) which are then built up using vagrant and a hypervisor. This saves
time when using Vagrant to build up VM instances as no extra installations have to be performed.

1. Packer configures and builds *.box files using *-packer.json files
    - 1 Box with puppet-server installed & configured
    - 1 Box with puppet-agent installed & configured
2. Vagrant uses local *.box files to create VM instances.

## Process

Look at `ci` directory and `gitlab-ci.yml`.

Quick overview of steps:
1. `packer build puppetmaster-packer.json`
2. `packer build puppetagent-packer.json`
3. `vagrant up`

## Notes:

- Puppet installation guide used - https://www.howtoforge.com/tutorial/how-to-setup-puppet-master-and-agent-on-centos-7/
- Boxes use ACE specific ntp server to synchronise time (change if not connected to VPN) 
- May need to set/unset `http_proxy`, `https_poxy`, `HTTP_PROXY`, `HTTPS_PROXY` environment variables 
    - to pull from ACE puppet forge
    - to push puppet master configuration changes to puppet agent (unset)
- Will need to register the puppet agent to the puppet master before use.
    - Send Certificate Signing Request
    - Sign the certificate
    - Example of this can be seen in `run_test.sh`
