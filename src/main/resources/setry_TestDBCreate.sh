#!/usr/bin/env bash
#

ARGS=1
BAD_PARAMS=65
NOMATCH=126
ROLE_NAME=hadoop-qa
ROLE_GROUP=hadoop-qa
DB_NAME=test_bin

export HADOOP_HOME=/opt/meituan/hadoop
export SENTRY_HOME=/opt/meituan/sentry
source /opt/meituan/hadoop/bin/hadoop_user_login.sh hive

[ $# -ne $ARGS ] && echo "Usage: `basename $0` (setup|clean|check)" && exit $BAD_PARAMS

case "$1" in
"setup")
#Add role, group and privilege
/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -create_role -r $ROLE_NAME
/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -add_role_group -r $ROLE_NAME -g $ROLE_GROUP
/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename $ROLE_NAME --privilege "server=server1->db=$DB_NAME->action=create"
;;
"clean")
 #Remove role, group and privilege
/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --revoke_privilege_role -r $ROLE_NAME -p "server=server1->db=$DB_NAME->action=create"
/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --delete_role_group -r $ROLE_NAME -g $ROLE_GROUP
/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --drop_role -r $ROLE_NAME
 ;;
"check")
#Check role, group and privilege
/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --list_role
#/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --list_role -g $ROLE_GROUP
#/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --list_privilege -r $ROLE_NAME
;;
* ) return $NOMATCH;;
esac