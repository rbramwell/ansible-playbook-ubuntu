#!/bin/bash

set -o xtrace

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

ansible-playbook -i hosts playbooks/setup-ubuntu.yml "$@"
