#!/bin/bash
#filename: sentry_env.sh
#
#The script will define all sentryShell environment variable that it needs
#

# Define param and env
ARGS=2
BAD_PARAMS=65
NOMATCH=126
NOPRI=61
LOGIN_USER=hive
DB_NAME=test_db2

export HADOOP_HOME=/opt/meituan/hadoop
export SENTRY_HOME=/opt/meituan/sentry
source /opt/meituan/hadoop/bin/hadoop_user_login.sh $LOGIN_USER


# Check CLI parameter
[ $# -ne $ARGS ] && echo "Usage: `basename $BASH_SOURCE` (setup|clean|check) (privilege)" && exit $BAD_PARAMS

# Select the corresponding privilege
declare -A sentry_privileges

# It will be used to setup and clean privilege with highest privilege
sentry_privileges[SuperPrivil]="server=server1->action=all"

# The following will be used to setup and clean and check privilege for each object
sentry_privileges[ServerAll]="server=server1->action=all"
sentry_privileges[ServerCreate]="server=server1->action=create"
sentry_privileges[ServerSelect]="server=server1->action=select"
sentry_privileges[ServerInsert]="server=server1->action=insert"

sentry_privileges[ColumnAll]="server=server1->db=db4create->action=all,server=server1->db=db4drop->action=all,server=server1->db=db4drop_cascade->action=all,server=server1->db=db4alter->action=all,server=server1->db=test_db2->action=all,server=server1->db=db4tbl->action=all"

sentry_privileges[DBCreate]="server=server1->db=test_db2->action=create"
sentry_privileges[DBSelect]="server=server1->db=test_db2->action=select"
sentry_privileges[DBInsert]="server=server1->db=db4alter->action=insert,server=server1->db=db4alter2->action=insert,server=server1->db=db4load->action=insert,server=server1->db=db4overwrite->action=insert,server=server1->db=db4query->action=insert,server=server1->db=db4func->action=insert,server=server1->db=db4addfile->action=insert,server=server1->db=test_db->action=insert"


if [[ "$2" == "ServerAll" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[ServerAll]}"`
elif [[ "$2" == "SuperPrivil" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[SuperPrivil]}"`
elif [[ "$2" == "DBCreate" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[DBCreate]}"`
elif [[ "$2" == "DBSelect" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[DBSelect]}"`
elif [[ "$2" == "DBInsert" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[DBInsert]}"`
elif [[ "$2" == "ColumnAll" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[ColumnAll]}"`
elif [[ "$2" == "List" ]]; then # For show privilege to specify $2 with List
    : ${privilege:="placeholder"}
else
    echo "Please specify valid sentry privilege"
    exit $NOPRI
fi


# set role name and role group for specify privilege
if [[ "$2" == "SuperPrivil" ]]; then
    ROLE_NAME=hive_qa
    ROLE_GROUP=hive_qa
else
    ROLE_NAME=hdp_qa
    ROLE_GROUP=hdp_qa
fi


case "$1" in
    "setup")
        # Add role, group and privilege
        $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --create_role -r $ROLE_NAME
        $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --add_role_group -r $ROLE_NAME -g $ROLE_GROUP

        for privil in $privileges; do
            $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --grant_privilege_role --rolename $ROLE_NAME --privilege "$privil"
        done
        ;;
    "clean")
        # Remove role, group and privilege
        for privil in $privileges; do
            $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --revoke_privilege_role -r $ROLE_NAME -p "$privil"
        done

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
