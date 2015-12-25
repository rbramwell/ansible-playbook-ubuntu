#!/bin/bash

set -o xtrace

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

# Fetch all roles with latest version.
rm -rf roles
git checkout -- roles
git submodule init
git submodule update --remote
