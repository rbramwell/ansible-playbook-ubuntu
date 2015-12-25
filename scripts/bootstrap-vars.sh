#!/bin/bash

set -o xtrace

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

# Generate a random password.
PASSWD=`< /dev/urandom tr -dc A-Za-z0-9 | head -c8`
SALT=`date | shasum -a 256 | sed 's/^\(\w*\).*$/\1/g'`

# Prepare group_vars/all.
TMP_VARS=`mktemp`
echo -e "# Updated on `date`" >> $TMP_VARS
find roles/*/defaults/*.yml -type f -exec cat {} \; | egrep -e '^\w*:' | sort -u | sed 's/^/#/g;s/\[$/[]/g;s/{$/{}/g' >> $TMP_VARS
echo -en '\n' >> $TMP_VARS
perl -i -p -e "s/^#(apt_cache_valid_time):.*/\1: 3600/g" $TMP_VARS
perl -i -p -e "s/^#(apt_upgrade):.*/\1: full/g" $TMP_VARS
cat $TMP_VARS >> group_vars/all
