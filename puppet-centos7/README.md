Setup
=====

1. vagrant up
2. vagrant ssh puppet_master_box
3. sudo -i
4. /vagrant/scripts/setup_certificates.sh
5. vagrant ssh puppet_agent_box
6. sudo -i
7. puppet agent -t

# Ready to use

