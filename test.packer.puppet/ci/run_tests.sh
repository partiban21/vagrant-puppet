#!/bin/bash
set -eu

exit_code=0

vagrant up

# test that root of the project is mounted at /vagrant in the VM
if [[ $(cat ./app.blueprint) == "$(vagrant ssh puppetmaster --no-tty -c 'cat /vagrant/app.blueprint')" ]]; then
        echo "SUCCESS: root of the project is mounted at /vagrant inside the VM"
else    
        echo "FAILURE: root of the project not mounted inside the VM at /vagrant"
        exit_code=1
fi

if [[ $(cat ./app.blueprint) == "$(vagrant ssh puppetagent --no-tty -c 'cat /vagrant/app.blueprint')" ]]; then
        echo "SUCCESS: root of the project is mounted at /vagrant inside the VM"
else
        echo "FAILURE: root of the project not mounted inside the VM at /vagrant"
        exit_code=1
fi

vagrant ssh puppetmaster --no-tty -c "/opt/puppetlabs/bin/puppet --version"
vagrant ssh puppetagent --no-tty -c "/opt/puppetlabs/bin/puppet --version"
vagrant ssh puppetmaster --no-tty -c "cat /etc/hosts"
vagrant ssh puppetagent --no-tty -c "cat /etc/hosts"
vagrant ssh puppetmaster --no-tty -c "ping puppetagent -c 3"
vagrant ssh puppetagent --no-tty -c "ping puppetmaster -c 3"

# register puppet agent to the puppet master (certificate)
vagrant ssh puppetmaster --no-tty -c "sudo sed -i '1,4 s/^/#/' /etc/environment; source /etc/environment && sudo sed -i '1,4 s/^/#/' /etc/profile.d/ace-proxy.sh; source /etc/profile.d/ace-proxy.sh"
vagrant ssh puppetagent --no-tty -c "sudo sed -i '1,4 s/^/#/' /etc/environment; source /etc/environment && sudo sed -i '1,4 s/^/#/' /etc/profile.d/ace-proxy.sh; source /etc/profile.d/ace-proxy.sh"

vagrant ssh puppetagent --no-tty -c "sudo /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true"
vagrant ssh puppetmaster --no-tty -c "sudo /opt/puppetlabs/bin/puppet cert list && sudo /opt/puppetlabs/bin/puppet cert sign puppetagent"
vagrant ssh puppetagent --no-tty -c "sudo /opt/puppetlabs/bin/puppet agent --test"

exit ${exit_code}
