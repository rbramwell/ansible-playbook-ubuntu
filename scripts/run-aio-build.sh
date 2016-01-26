#!/bin/bash

set -o xtrace

# Install basic packages for this script.
apt-get update
apt-get -y install git

# GIT clone our playbook to CWD.
git clone --recursive https://github.com/pantarei/ansible-playbook-ubuntu.git /opt/ansible-playbook-ubuntu
cd /opt/ansible-playbook-ubuntu

# Generate SSH key for localhost connection.
echo -e 'y\n' | ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ''
cat ~/.ssh/id_rsa >> ~/.ssh/authorized_keys

# Bootstrap Ansible then run all playbooks.
scripts/bootstrap-ansible.sh
scripts/bootstrap-roles.sh
scripts/bootstrap-group_vars.sh
scripts/bootstrap-inventory.sh
ansible-playbook -i inventory/localhost playbooks/run-aio-build.yml
