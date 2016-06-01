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
perl -i -p -e "s/^#(apache2_http_port):.*/\1: \"80\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_https_port):.*/\1: \"443\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_base):.*/\1: \"{{ apache2_vhosts_home }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_document_root):.*/\1: \"{{ apache2_vhosts_base }}\/public_html\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_gid):.*/\1: ~/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_handler_php):.*/\1: \"proxy:unix:\/var\/run\/php\/{{ apache2_vhosts_id }}_php7.0-fpm.sock|fcgi:\/\/localhost\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_hash_salt):.*/\1: \"$SALT\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_home):.*/\1: \"\/home\/{{ apache2_vhosts_user }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_http_port):.*/\1: \"{{ apache2_http_port }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_https_port):.*/\1: \"{{ apache2_https_port }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_id):.*/\1: \"example\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_pass):.*/\1: \"$PASSWD\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_server_alias):.*/\1: [\n  \"www.example.com\",\n  \"*\",\n]/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_server_name):.*/\1: \"example.com\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_uid):.*/\1: ~/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_user):.*/\1: \"example\"/g" $TMP_VARS
perl -i -p -e "s/^#(apt_cache_valid_time):.*/\1: \"3600\"/g" $TMP_VARS
perl -i -p -e "s/^#(apt_upgrade):.*/\1: \"full\"/g" $TMP_VARS
perl -i -p -e "s/^#(mysql_port):.*/\1: \"3306\"/g" $TMP_VARS
perl -i -p -e "s/^#(mysql_vhosts_id):.*/\1: \"{{ apache2_vhosts_id }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(mysql_vhosts_pass):.*/\1: \"{{ apache2_vhosts_pass }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(mysql_vhosts_user):.*/\1: \"{{ apache2_vhosts_user }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(php_date_timezone):.*/\1: \"Etc\/UTC\"/g" $TMP_VARS
perl -i -p -e "s/^#(php_vhosts_base):.*/\1: \"{{ apache2_vhosts_base }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(php_vhosts_date_timezone):.*/\1: \"{{ php_date_timezone }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(php_vhosts_gid):.*/\1: \"{{ apache2_vhosts_gid }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(php_vhosts_hash_salt):.*/\1: \"{{ apache2_vhosts_hash_salt }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(php_vhosts_home):.*/\1: \"{{ apache2_vhosts_home }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(php_vhosts_id):.*/\1: \"{{ apache2_vhosts_id }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(php_vhosts_pass):.*/\1: \"{{ apache2_vhosts_pass }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(php_vhosts_uid):.*/\1: \"{{ apache2_vhosts_uid }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(php_vhosts_user):.*/\1: \"{{ apache2_vhosts_user }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(postgresql_port):.*/\1: \"5432\"/g" $TMP_VARS
perl -i -p -e "s/^#(postgresql_vhosts_id):.*/\1: \"{{ apache2_vhosts_id }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(postgresql_vhosts_pass):.*/\1: \"{{ apache2_vhosts_pass }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(postgresql_vhosts_user):.*/\1: \"{{ apache2_vhosts_user }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(tzdata_timezone):.*/\1: \"Etc\/UTC\"/g" $TMP_VARS
cat $TMP_VARS >> host_vars/ubuntu.aio
