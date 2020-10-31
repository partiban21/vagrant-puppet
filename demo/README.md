# Demo
This was my first attempt using vagrant to build a suitable environment to test
continuously deploying Puppet code from a Puppet Server into a Puppet Agent.

## Introduction
Each directory represents a vagrant box, which holds the configuration settings for each 
VirtualMachine (VM) instance created. Current existing ones include:
- Puppet Master
    - CentOS 7
- Puppet Agent
    - CentOS 7

Naming convention for each directory added is as follows: 
**puppet-(master|agent)-{linux_distribution}{version}**

##Setup
1. cd into directory of VM you want to create
2. Read Vagrantfile within directory and setup system prerequisites + make custom config changes e.g:
    - Ensure (base image) vagrant box is installed on system
        - `vagrant box list`
    - Change values of configured environment to meet your needs e.g:
        - Memory
        - CPU
        - hostname
        - IP address
3. Boot VM - `vagrant up`
4. Open ssh session for VM - `vagrant ssh`
5. cd to `/vagrant` within VM instances and run bash scripts to set up Puppet environment.
    - Order:
        1. setup-puppetmaster.sh
        2. setup-puppetagent.sh
        3. setup-certificates.sh
