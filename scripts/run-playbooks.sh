#!/bin/bash

set -o xtrace

ansible-playbook -i inventory/localhost.localdomain playbooks/setup-everything.yml
