#!/bin/bash

set -o xtrace

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

# Copy hosts files from template.
echo -e "# Updated on `date`" >> hosts
cat >> hosts <<-EOF
[locales]
localhost   ansible_connection=local

[tzdata]
localhost   ansible_connection=local

[ntp]
localhost   ansible_connection=local

EOF
