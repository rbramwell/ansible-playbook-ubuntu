#!/bin/bash

set -o xtrace

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

# Fetch all roles with latest version.
rm -rf roles
ansible-galaxy install --force -r .roles.yml
