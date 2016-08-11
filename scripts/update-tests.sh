#!/bin/bash

set -o xtrace

rm -rf inventory/ubuntu.aio/group_vars/all
rm -rf inventory/ubuntu.aio/hosts

scripts/bootstrap-inventory.sh
scripts/bootstrap-ubuntu.sh

cat inventory/ubuntu.aio/group_vars/all | egrep -v -e '^^#\w' | perl -p -e "s/^(apt_upgrade):.*/\1: \"no\"/g" > tests/group_vars/all
cat inventory/ubuntu.aio/hosts | perl -p -e "s/^.*127.0.0.1/localhost.localdomain\tansible_connection=local/g" > tests/hosts
