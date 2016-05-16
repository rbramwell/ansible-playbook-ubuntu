#!/bin/bash

set -o xtrace

ansible-playbook -i inventory/ubuntu.aio playbooks/setup-everything.yml
