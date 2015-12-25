#!/bin/bash

set -o xtrace

# Install basic packages for this script.
apt-get update
apt-get -y install git

# GIT clone our playbook to CWD.
git clone --recursive https://github.com/pantarei/ansible-playbook-ubuntu.git /opt/ansible-playbook-ubuntu
cd /opt/ansible-playbook-ubuntu

# Bootstrap Ansible then run all playbooks.
scripts/bootstrap-ansible.sh
scripts/bootstrap-roles.sh
scripts/bootstrap-vars.sh
scripts/bootstrap-hosts.sh
scripts/run-playbooks.sh
