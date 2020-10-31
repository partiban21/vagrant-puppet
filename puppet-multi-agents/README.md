# Attempt #3
This was my attempt using vagrant to build a suitable environment to test
continuously deploying Puppet code from a Puppet Server into multiple 
Puppet Agents.

## Introduction
The vagrant boxes are all defined within one Vagrantfile which holds the 
configuration settings for all the VirtualMachine (VM) instances created:
- Puppet Master
    - CentOS 7
- Puppet Agent 2
    - CentOS 7
- Puppet Agent 2
    - Ubuntu 18.04

##Setup
1. Run factoryreset_vagrant_build.bat

