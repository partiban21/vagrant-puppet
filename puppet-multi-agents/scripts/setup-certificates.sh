#!/usr/bin/env bash

# Source: https://www.howtoforge.com/tutorial/how-to-setup-puppet-master-and-agent-on-centos-7/

# Ensure puppet agent is now running on the server, and it's attempting to register itself to the puppet master.
ping puppetagentcentos -c 3

/opt/puppetlabs/bin/puppet cert list
/opt/puppetlabs/bin/puppet cert sign --all

# verify working in puppet agent
echo "Run: 'puppet agent --test' in puppet agent"
