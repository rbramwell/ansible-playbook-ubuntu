#!/bin/bash

set -o xtrace

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

# Copy hosts files from template.
TMP_HOSTS=`mktemp`
echo -e "# Updated on `date`" >> $TMP_HOSTS
find playbooks/*.yml -type f -exec cat {} \; | grep "hosts:" | perl -p -e  's/^.*:\s(.*)/\1/g' | sort -u | grep -v "all" | while read line;
do
    cat >> $TMP_HOSTS <<-EOF
[$line]
localhost.localdomain	ansible_connection=local

EOF
done
cat $TMP_HOSTS >> inventory/aio
