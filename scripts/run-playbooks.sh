#!/bin/bash

set -o xtrace

ansible-playbook -i inventory/ubuntu.aio/hosts.aio playbooks/setup-everything.yml
