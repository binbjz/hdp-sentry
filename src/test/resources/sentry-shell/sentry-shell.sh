#!/usr/bin/env bash

ARGS=1
BAD_PARAMS=65
NOMATCH=126
ROLE_NAME=server_all
ROLE_GROUP=server_all_group
DB_NAME=test_db

export HADOOP_HOME=/opt/meituan/hadoop
export SENTRY_HOME=/opt/meituan/sentry
source /opt/meituan/hadoop/bin/hadoop_user_login.sh hive

[ $# -ne $ARGS ] && echo "Usage: `basename $0` (setup|clean|check)" && exit $BAD_PARAMS

case "$1" in
"setup")
# Add role, group and privilege
/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -create_role -r server_all
/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -add_role_group -r server_all -g server_all_group
/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename server_all --privilege "server=server1->action=all"
;;
"clean")
# Remove role, group and privilege
/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --revoke_privilege_role -r server_all -p "server=server1->action=all"
/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --delete_role_group -r server_all -g server_all_group
/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --drop_role -r server_all
 ;;
"check")
# Check role, group and privilege
/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --list_role
/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --list_role -g server_all_group
/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --list_privilege -r server_all
;;
* ) return $NOMATCH;;
esac