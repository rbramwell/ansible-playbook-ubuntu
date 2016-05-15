#!/bin/bash

set -o xtrace

ansible-playbook -i inventory/ubuntu playbooks/setup-everything.yml
