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

# Load sentry privileges template
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/sentry_privil_tmpl.sh

##============
# Sentry Flag Privilege
if [[ "$2" == "SentryFlagDropTable" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[SentryFlagDropTable]}"`
elif [[ "$2" == "SentryFlagDropDB" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[SentryFlagDropDB]}"`
elif [[ "$2" == "SentryFlagAlterTable" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[SentryFlagAlterTable]}"`


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

        #######################################################################
        # hive_env.sh
        #
        # CASE 1
        #export HADOOP_PROXY_USER=$PROXY_USER
        # CASE 2 & 3
        #export HADOOP_PROXY_USER=$PROXY_USER/$PROXY_USER@ALL
        #######################################################################
        #CASE 1 & 2
        #GRANT PRIVILEGE ON A GROUP RELATED ROLE
        #GROUP_ROLE_NAME1=dim_group_role
        #ROLE_GROUP1=dim_group
        #privil= ALL PRIVILEGES in sentry_privil_tmpl.sh
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -create_role -r $GROUP_ROLE_NAME1
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -add_role_group -r $GROUP_ROLE_NAME1 -g $ROLE_GROUP1
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -grant_privilege_role --rolename $GROUP_ROLE_NAME1 --privilege "$privil"
        #
        #
        #
        #GROUP_ROLE_NAME2=dw_group_role
        #ROLE_GROUP2=dw_group
        #privil=server=server1->db=test_group_db2->action=all
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -create_role -r $GROUP_ROLE_NAME2
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -add_role_group -r $GROUP_ROLE_NAME2 -g $ROLE_GROUP2
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -grant_privilege_role --rolename $GROUP_ROLE_NAME2 --privilege "$privil"
        #
        #sentry_privileges[ROLE_GROUP2]='server=server1->db=test_group_db2->action=all"
        #
        #USER_ROLE_NAME=hdp_qa_role
        #USER=hdp_qa
        #privil=server=server1->db=test_user_db->action=all
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -create_role -r $USER_ROLE_NAME
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -add_role_user -r $USER_ROLE_NAME -u $USER
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -grant_privilege_role --rolename $USER_ROLE_NAME --privilege "$privil"
        #
        #sentry_privileges[ROLE_USER]='server=server1->db=test_user_db->action=all"
        #
        #######################################################################
        #CASE 3
        #GROUP_ROLE_NAME1=dim_group_role
        #ROLE_GROUP1=dim_group
        #privil=server=server1->db=test_group_db1->action=all
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -create_role -r $GROUP_ROLE_NAME1
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -add_role_group -r $GROUP_ROLE_NAME1 -g $ROLE_GROUP1
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -grant_privilege_role --rolename $GROUP_ROLE_NAME1 --privilege "$privil"
        #
        #sentry_privileges[ROLE_GROUP1]='server=server1->db=test_group_db1->action=all"
        #
        #GROUP_ROLE_NAME2=dw_group_role
        #ROLE_GROUP2=dw_group
        #privil=server=server1->db=test_group_db2->action=all
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -create_role -r $GROUP_ROLE_NAME2
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -add_role_group -r $GROUP_ROLE_NAME2 -g $ROLE_GROUP2
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -grant_privilege_role --rolename $GROUP_ROLE_NAME2 --privilege "$privil"
        #
        #GRANT PRIVILEGE ON A USER RELATED ROLE
        #USER_ROLE_NAME=hdp_qa_role
        #USER=hdp_qa
        #privil= ALL PRIVILEGES in sentry_privil_tmpl.sh
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -create_role -r $USER_ROLE_NAME
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -add_role_user -r $USER_ROLE_NAME -u $USER
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -grant_privilege_role --rolename $USER_ROLE_NAME --privilege "$privil"

        ;;
    "clean")
        # Remove role, group and privilege
        for privil in $privileges; do
            $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --revoke_privilege_role -r $ROLE_NAME -p "$privil"
        done

        $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --delete_role_group -r $ROLE_NAME -g $ROLE_GROUP
        $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --drop_role -r $ROLE_NAME


        #######################################################################
        #CASE 1 & 2
        #REVOKE PRIVILEGE ON A GROUP RELATED ROLE
        #GROUP_ROLE_NAME1=dim_group_role
        #ROLE_GROUP1=dim_group
        #privil= ALL PRIVILEGES
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -revoke_privilege_role --rolename $GROUP_ROLE_NAME1 --privilege "$privil"
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -delete_role_group -r $GROUP_ROLE_NAME1 -g $ROLE_GROUP1
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -drop_role -r $GROUP_ROLE_NAME1

        #GROUP_ROLE_NAME2=dw_group_role
        #ROLE_GROUP2=dw_group
        #privil=server=server1->db=test_group_db2->action=all
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -revoke_privilege_role --rolename $GROUP_ROLE_NAME2 --privilege "$privil"
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -delete_role_group -r $GROUP_ROLE_NAME2 -g $ROLE_GROUP2
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -drop_role -r $GROUP_ROLE_NAME2

        #USER_ROLE_NAME=hdp_qa_role
        #USER=hdp_qa
        #privil=server=server1->db=test_user_db->action=all
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -revoke_privilege_role --rolename $USER_ROLE_NAME --privilege "$privil"
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -delete_role_user -r $USER_ROLE_NAME -u $USER
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -drop_role -r $USER_ROLE_NAME

        #######################################################################
        #CASE 3
        #GROUP_ROLE_NAME1=dim_group_role
        #ROLE_GROUP1=dim_group
        #privil=server=server1->db=test_group_db1->action=all
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -revoke_privilege_role --rolename $GROUP_ROLE_NAME1 --privilege "$privil"
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -delete_role_group -r $GROUP_ROLE_NAME1 -g $ROLE_GROUP1
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -drop_role -r $GROUP_ROLE_NAME1

        #GROUP_ROLE_NAME2=dw_group_role
        #ROLE_GROUP2=dw_group
        #privil=server=server1->db=test_group_db2->action=all
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -revoke_privilege_role --rolename $GROUP_ROLE_NAME2 --privilege "$privil"
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -delete_role_group -r $GROUP_ROLE_NAME2 -g $ROLE_GROUP2
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -drop_role -r $GROUP_ROLE_NAME2

        #REVOKE PRIVILEGE ON A USER RELATED ROLE
        #USER_ROLE_NAME=hdp_qa_role
        #USER=hdp_qa
        #privil= ALL PRIVILEGES
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -grant_privilege_role --rolename $USER_ROLE_NAME --privilege "$privil"
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -delete_role_user -r $USER_ROLE_NAME -u $USER
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -drop_role -r $USER_ROLE_NAME

        ;;
    "check")
        # Check role, group and privilege
        # Too many roles, so temporary comment the line.
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_role
        $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_role -g $ROLE_GROUP
        $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_privilege -r $ROLE_NAME


        #######################################################################
        # hive_env.sh
        #
        # CASE 1
        #export HADOOP_PROXY_USER=$PROXY_USER
        # CASE 2 & 3
        #export HADOOP_PROXY_USER=$PROXY_USER/$PROXY_USER@ALL
        #######################################################################
        #CASE 1 & 2
        #CHECK PRIVILEGE ON A GROUP RELATED ROLE
        #GROUP_ROLE_NAME1=dim_group_role
        #ROLE_GROUP1=dim_group
        #privil= ALL PRIVILEGES
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_privilege -r $GROUP_ROLE_NAME1
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_role -g $ROLE_GROUP1
        #
        #GROUP_ROLE_NAME2=dw_group_role
        #ROLE_GROUP2=dw_group
        #privil=server=server1->db=test_group_db2->action=all
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_privilege -r $GROUP_ROLE_NAME2
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_role -g $ROLE_GROUP2
        #
        #USER_ROLE_NAME=hdp_qa_role
        #USER=hdp_qa
        #privil=server=server1->db=test_user_db->action=all
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_privilege -r $USER_ROLE_NAME
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_role -u $USER
        #######################################################################
        #CASE 3
        #GROUP_ROLE_NAME1=dim_group_role
        #ROLE_GROUP1=dim_group
        #privil=server=server1->db=test_group_db1->action=all
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_privilege -r $GROUP_ROLE_NAME1
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_role -g $ROLE_GROUP1
        #
        #GROUP_ROLE_NAME2=dw_group_role
        #ROLE_GROUP2=dw_group
        #privil=server=server1->db=test_group_db2->action=all
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_privilege -r $GROUP_ROLE_NAME2
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_role -g $ROLE_GROUP2
        #
        #CHECK PRIVILEGE ON A USER RELATED ROLE
        #USER_ROLE_NAME=hdp_qa_role
        #USER=hdp_qa
        #privil= ALL PRIVILEGES
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_privilege -r $USER_ROLE_NAME
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_role -u $USER

        ;;
    * )
    echo "Please specify valid action"
    exit $NOMATCH;;
esac
