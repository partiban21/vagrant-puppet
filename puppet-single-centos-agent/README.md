# Attempt #2

Automate the process of building a Puppet Master and Puppet Server. 
Using the `factoryreset_vagrant_build.bat` to tear down and build up 
new instances of the boxes to ensure all changes are accounted for.

# Setup
1. `./factoryreset_vagrant_build.bat`

OR

1. Build the 2 vagrant boxes. (1 with Puppet Server, 1 with Puppet agent installed)
    - `vagrant up`
2. Ensure the boxes have been created and are running
    - `vagrant global-status`
3. SSH into each box in separate terminals/consoles.
    - `vagrant ssh puppet_master_box`
    - `vagrant ssh puppet_agent_box`
    - (optional) `sudo -i`
4. Authenticate the Puppet Agent in the Puppet Server box
    - `sudo /vagrant/scripts/setup-certificates.sh`
5. Confirm the Puppet Agent is correctly configured to the Puppet Server.
    - `puppet agent -t`

# Usage

This is a puppet test environment.
1. Clone your Puppet Repository into your Puppet Server
2. 
3. Pull these changes into your Puppet Agent
