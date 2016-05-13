#!/bin/bash

set -o xtrace

ansible-playbook -i inventory/aio playbooks/setup-everything.yml
