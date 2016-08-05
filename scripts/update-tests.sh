#!/bin/bash

set -o xtrace

rm -rf host_vars/ubuntu.aio
rm -rf inventory/ubuntu.aio

scripts/bootstrap-inventory.sh
scripts/bootstrap-ubuntu.sh

cat host_vars/ubuntu.aio | egrep -v -e '^^#\w' | perl -p -e "s/^(apt_upgrade):.*/\1: \"no\"/g" > tests/group_vars/all
cat inventory/ubuntu.aio | perl -p -e "s/^.*127.0.0.1/localhost.localdomain\tansible_connection=local/g" > tests/hosts
