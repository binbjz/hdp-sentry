#!/bin/bash
#filename: sentry_env.sh
#
#The script will grant sentry role and group privilege for proxy user and keytab login way
#

# Define param and env
ARGS=2
BAD_PARAMS=65
NOMATCH=126
NOPRI=61
LOGIN_USER=hive
DB_NAME=testdb

export HADOOP_HOME=/opt/meituan/hadoop
export SENTRY_HOME=/opt/meituan/sentry
source /opt/meituan/hadoop/bin/hadoop_user_login.sh $LOGIN_USER


# Check CLI parameter
[ $# -ne $ARGS ] && echo "Usage: `basename $BASH_SOURCE` (setup|clean|check) (privilege)" && exit $BAD_PARAMS


##============
# set the corresponding privilege
declare -A sentry_privileges


##============
# Sentry Flag
if [[ "$2" == "SentryFlagTable" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[SentryFlagTable]}"`
elif [[ "$2" == "SentryFlagDB" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[SentryFlagDB]}"`

# Super Privilege
elif [[ "$2" == "SuperPrivil" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[SuperPrivil]}"`

# Server Privilege
elif [[ "$2" == "ServerAll" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[ServerAll]}"`
elif [[ "$2" == "ServerCreate" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[ServerCreate]}"`
elif [[ "$2" == "ServerAlter" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[ServerAlter]}"`
elif [[ "$2" == "ServerDrop" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[ServerDrop]}"`
elif [[ "$2" == "ServerInsert" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[ServerInsert]}"`
elif [[ "$2" == "ServerSelect" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[ServerSelect]}"`
elif [[ "$2" == "ServerWrite" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[ServerWrite]}"`

# DB Privilege
elif [[ "$2" == "DBAll" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[DBAll]}"`
elif [[ "$2" == "DBCreate" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[DBCreate]}"`
elif [[ "$2" == "DBSelect" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[DBSelect]}"`
elif [[ "$2" == "DBAlter" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[DBAlter]}"`
elif [[ "$2" == "DBInsert" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[DBInsert]}"`
elif [[ "$2" == "DBDrop" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[DBDrop]}"`
elif [[ "$2" == "DBWrite" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[DBWrite]}"`

# Table Privilege
elif [[ "$2" == "TableAll" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[TableAll]}"`
elif [[ "$2" == "TableAlter" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[TableAlter]}"`
elif [[ "$2" == "TableCreate" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[TableCreate]}"`
elif [[ "$2" == "TableDrop" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[TableDrop]}"`
elif [[ "$2" == "TableInsert" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[TableInsert]}"`
elif [[ "$2" == "TableSelect" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[TableSelect]}"`
elif [[ "$2" == "TableWrite" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[TableWrite]}"`

# Encrypted Columns Privilege
elif [[ "$2" == "DBAllWithEncryptedColumns" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[DBAllWithEncryptedColumns]}"`
elif [[ "$2" == "DBAllWithEncryptedColumns_2" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[DBAllWithEncryptedColumns_2]}"`
elif [[ "$2" == "DBAllWithEncryptedColumns_3" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[DBAllWithEncryptedColumns_3]}"`

# For show privilege to specify $2 with List
elif [[ "$2" == "List" ]]; then
    : ${privilege:="placeholder"}
else
    echo "Please specify valid sentry privilege"
    exit $NOPRI
fi


# set role name and role group for specify privilege
if [[ "$2" == "SuperPrivil" ]]; then
    ROLE_NAME=mt_qa
    ROLE_GROUP=mt_qa
else
    ROLE_NAME=hdp_qa
    ROLE_GROUP=hdp_qa
fi


# Exec Privilege
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
        # Too many roles, so temporary comment the line.
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_role
        $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_role -g $ROLE_GROUP
        $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_privilege -r $ROLE_NAME
        ;;
    * )
    echo "Please specify valid action"
    exit $NOMATCH;;
esac
