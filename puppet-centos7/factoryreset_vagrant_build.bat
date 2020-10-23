::echo "Hello World"

:: Prints the name of the execuing file
::echo "%0"

:: Prints the full path of the executing file
::echo "%~f0"

:: Prints the full directory path of the executing path - w/o file name
::echo "%~dp0"

cd "%~dp0"
vagrant destroy --force
vagrant up
vagrant ssh puppet_master_box -c "sudo /vagrant/scripts/setup-certificates.sh"
vagrant ssh puppet_agent_box -c "sudo /opt/puppetlabs/bin/puppet agent -t"
