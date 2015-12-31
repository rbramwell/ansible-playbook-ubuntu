#!/bin/bash

set -o xtrace

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

# Copy hosts files from template.
echo -e "# Updated on `date`" >> hosts
cat >> hosts <<-EOF
#[apt]
#localhost   ansible_connection=local

#[hostname]
#localhost   ansible_connection=local

#[locales]
#localhost   ansible_connection=local

#[ntp]
#localhost   ansible_connection=local

#[tzdata]
#localhost   ansible_connection=local

#[ufw]
#localhost   ansible_connection=local

#[usermin]
#localhost   ansible_connection=local

#[webmin]
#localhost   ansible_connection=local

EOF
