#!/bin/bash

set -o xtrace

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

# Generate a random password.
PASSWD=`< /dev/urandom tr -dc A-Za-z0-9 | head -c8`
SALT=`< /dev/urandom tr -dc A-Za-z0-9 | head -c16`

# Prepare group_vars/all.
TMP_VARS=`mktemp`
echo -e "# Updated on `date`" >> $TMP_VARS
find roles/*/defaults/*.yml -type f -exec cat {} \; | egrep -e '^\w*:' | sort -u | sed 's/^/#/g;s/\[$/[]/g;s/{$/{}/g' >> $TMP_VARS
echo -en '\n' >> $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_hash_salt):.*/\1: \"$SALT\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_id):.*/\1: example/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_pass):.*/\1: \"$PASSWD\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_user):.*/\1: example/g" $TMP_VARS
perl -i -p -e "s/^#(apt_cache_valid_time):.*/\1: 3600/g" $TMP_VARS
perl -i -p -e "s/^#(apt_upgrade):.*/\1: full/g" $TMP_VARS
perl -i -p -e "s/^#(mysql_vhosts_id):.*/\1: \"{{ apache2_vhosts_id }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(mysql_vhosts_pass):.*/\1: \"{{ apache2_vhosts_pass }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(mysql_vhosts_user):.*/\1: \"{{ apache2_vhosts_user }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(php_date_timezone):.*/\1: Etc\/UTC/g" $TMP_VARS
perl -i -p -e "s/^#(php_vhosts_date_timezone):.*/\1: Etc\/UTC/g" $TMP_VARS
perl -i -p -e "s/^#(php_vhosts_hash_salt):.*/\1: \"{{ apache2_vhosts_hash_salt }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(php_vhosts_id):.*/\1: \"{{ apache2_vhosts_id }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(php_vhosts_pass):.*/\1: \"{{ apache2_vhosts_pass }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(php_vhosts_user):.*/\1: \"{{ apache2_vhosts_user }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(postgresql_vhosts_id):.*/\1: \"{{ apache2_vhosts_id }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(postgresql_vhosts_pass):.*/\1: \"{{ apache2_vhosts_pass }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(postgresql_vhosts_user):.*/\1: \"{{ apache2_vhosts_user }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(tzdata_timezone):.*/\1: Etc\/UTC/g" $TMP_VARS
perl -i -p -e "s/^#(ufw_route):.*/\1: []/g" $TMP_VARS
cat $TMP_VARS >> group_vars/all
