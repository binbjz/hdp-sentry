#!/bin/bash
#filename: sentry_env.sh
#
#The script will define all sentryShell environment variable that it needs
#

# Load env
source ~/.bashrc ~/.bash_profile /etc/profile /etc/bashrc

# Define param and env
ARGS=2
BAD_PARAMS=65
NOMATCH=126
NOPRI=61
LOGIN_USER=hive
ROLE_NAME=hdp_qa
ROLE_GROUP=hdp_qa
DB_NAME=test_db2

export HADOOP_HOME=/opt/meituan/hadoop
export SENTRY_HOME=/opt/meituan/sentry
source /opt/meituan/hadoop/bin/hadoop_user_login.sh $LOGIN_USER


# Check CLI parameter
[ $# -ne $ARGS ] && echo "Usage: `basename $BASH_SOURCE` (setup|clean|check) (privilege)" && exit $BAD_PARAMS

# Select the corresponding privilege
declare -A sentry_privilege
sentry_privilege[ServerAll]="'server=server1->action=all'"
sentry_privilege[DBCreate]="'server=server1->db=${DB_NAME}->action=create'"
sentry_privilege[ColumnAll]="'server=server1->db=${DB_NAME}->table=test_tbl->column=a->action=all,server=server1->db=${DB_NAME}->table=test_tbl->column=b->action=all'"

if [[ "$2" == "ServerAll" ]]; then
    privilege=${sentry_privilege[ServerAll]}
elif [[ "$2" == "TestDBCreate" ]]; then
    privilege=${sentry_privilege[DBCreate]}
elif [[ "$2" == "TestColumnAll" ]]; then
    privilege=${sentry_privilege[ColumnAll]}
elif [[ "$2" == "List" ]]; then # For show privilege to specify $2 with List
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
    # Too many roles and temporary comment the line.
    #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_role
    $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_role -g $ROLE_GROUP
    $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_privilege -r $ROLE_NAME
    ;;
* )
echo "Please specify valid action"
exit $NOMATCH;;
esac
