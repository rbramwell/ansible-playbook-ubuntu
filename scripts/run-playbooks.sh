#!/bin/bash

set -o xtrace

ansible-playbook -i inventory/ubuntu.aio/hosts playbooks/setup-everything.yml
