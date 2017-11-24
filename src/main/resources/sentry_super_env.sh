#!/bin/bash
#filename: sentry_super_env.sh
#
#The script will grant sentry user, role and group with super privilege
#

# Define param and env
ARGS=2
BAD_PARAMS=65
NOMATCH=126
NOPRI=61
LOGIN_USER=hive

export HADOOP_HOME=/opt/meituan/hadoop
export SENTRY_HOME=/opt/meituan/sentry
source /opt/meituan/hadoop/bin/hadoop_user_login.sh $LOGIN_USER


# Check CLI parameter
[ $# -ne $ARGS ] && echo "Usage: `basename $BASH_SOURCE` (setup|clean|check) (SuperPrivil)" && exit $BAD_PARAMS


# Load sentry privileges template
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/sentry_privil_tmpl.sh


##============
# set role name and role group for super privilege
ROLE_NAME=mt_qa
ROLE_GROUP=mt_qa


if [[ "$2" == "SuperPrivil" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[SuperPrivil]}"`
else
    echo "Please specify valid sentry privilege"
    exit $NOPRI
fi


case "$1" in
    "setup")
        # Add role, group with super privilege
        priv_formatter g $ROLE_NAME, $ROLE_GROUP

        $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --create_role -r $ROLE_NAME
        $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --add_role_group -r $ROLE_NAME -g $ROLE_GROUP

        for privil in $privileges; do
            $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --grant_privilege_role --rolename $ROLE_NAME --privilege "$privil"
        done
        ;;
    "clean")
        # Remove super privilege for role, group
        priv_formatter r $ROLE_NAME, $ROLE_GROUP

        for privil in $privileges; do
            $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --revoke_privilege_role -r $ROLE_NAME -p "$privil"
        done

        $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --delete_role_group -r $ROLE_NAME -g $ROLE_GROUP
        $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --drop_role -r $ROLE_NAME
        ;;
    "check")
        # Check super privilege for role, group
        priv_formatter c $ROLE_NAME, $ROLE_GROUP

        $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_role -g $ROLE_GROUP
        $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_privilege -r $ROLE_NAME
        ;;
    * )
    echo "Please specify valid action"
    exit $NOMATCH;;
esac
