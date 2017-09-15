#!/usr/bin/env bash
#filename: sentry_env.sh
#
#The script will define all sentryShell environment variable that it needs
#

# Define param and env
ARGS=2
BAD_PARAMS=65
NOMATCH=126
NOPRI=61
ROLE_NAME=server_all
ROLE_GROUP=server_all_group
DB_NAME=test_db

export HADOOP_HOME=/opt/meituan/hadoop
export SENTRY_HOME=/opt/meituan/sentry
source /opt/meituan/hadoop/bin/hadoop_user_login.sh hive

# Check CLI parameter
[ $# -ne $ARGS ] && echo "Usage: `basename $0` (setup|clean|check) (privilege)" && exit $BAD_PARAMS

# Select the corresponding privilege
declare -A sentry_privilege
sentry_privilege[TestServerAll]="server=server1->action=all"
sentry_privilege[TestDBCreate]="server=server1->db=test_db->action=create"
sentry_privilege[TestColumnAll]="server=server1->db=test_db->table=test_tbl->column=a->action=all,server=server1->db=test_db->table=test_tbl->column=b->action=all"

if [[ "$2" == "TestServerAll" ]]; then
    privilege=sentry_privilege[TestServerAll]
elif [[ "$2" == "TestDBCreate" ]]; then
    privilege=sentry_privilege[TestDBCreate]
elif [[ "$2" == "TestColumnAll" ]]; then
    privilege=sentry_privilege[TestColumnAll]
elif [[ "$2" == "Test" ]]; then
    :
else
    echo "Please specify valid sentry privilege"
    exit $NOPRI
fi

# Select the corresponding action
case "$1" in
"setup")
# Add role, group and privilege
$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -create_role -r $ROLE_NAME
$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -add_role_group -r $ROLE_NAME -g $ROLE_GROUP
$SENTRY_HOME/bin/sentryShell --conf $SENTRY_HOME/conf/sentry-site.xml --grant_privilege_role --rolename $ROLE_NAME --privilege "$privilege"
;;
"clean")
# Remove role, group and privilege
$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --revoke_privilege_role -r $ROLE_NAME -p "$privilege"
$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --delete_role_group -r $ROLE_NAME -g $ROLE_GROUP
$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --drop_role -r $ROLE_NAME
 ;;
"check")
# Check role, group and privilege
$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_role
$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_role -g $ROLE_GROUP
$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_privilege -r $ROLE_NAME
;;
* )
echo "Please specify valid action"
exit $NOMATCH;;
esac

exit 0