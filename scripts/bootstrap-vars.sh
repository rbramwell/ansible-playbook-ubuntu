#!/bin/bash

set -o xtrace

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

# Generate the group_vars/all with all default role variables.
PASSWD=`< /dev/urandom tr -dc A-Za-z0-9 | head -c8`
TMP_VARS=`mktemp`

echo -e "# Updated on `date`" >> $TMP_VARS
find roles/*/defaults/*.yml -type f -exec cat {} \; | egrep -e '^\w*:' | sort -u | sed 's/^/#/g' >> $TMP_VARS
echo -en '\n' >> $TMP_VARS

sed -i "s/^#\(apt_cache_valid_time\):.*/\1: 0/g" $TMP_VARS
sed -i "s/^#\(apt_upgrade\):.*/\1: full/g" $TMP_VARS

cat $TMP_VARS >> group_vars/all
