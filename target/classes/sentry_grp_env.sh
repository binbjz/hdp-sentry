#!/bin/bash
#filename: sentry_grp_env.sh
#
#The script will grant sentry role and group privilege for proxy user+group login way
#

# Define param and env
ARGS=2
BAD_PARAMS=66
NOMATCH=127
NOPRI=62
LOGIN_USER=hive
group_login_regex="^GroupLogin$|^GroupLogin_(2|3)$"

export HADOOP_HOME=/opt/meituan/hadoop
export SENTRY_HOME=/opt/meituan/sentry
source /opt/meituan/hadoop/bin/hadoop_user_login.sh $LOGIN_USER


# Check CLI parameter
[ $# -ne $ARGS ] && echo "Usage: `basename $BASH_SOURCE` (setup|clean|check) (privilege)" && exit $BAD_PARAMS


# Load sentry privileges template
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/sentry_privil_tmpl.sh


# Just verify sentry group login privilege key validity
if [[ "$2" =~ $group_login_regex ]]; then
    :
else
    echo "Please specify valid sentry group login privilege key"
    exit $NOPRI
fi


# Split and grant privilege to multiple users and the corresponding groups
groups_login=${sentry_privileges[$2]} # Mark -- Need to modify GroupLogin to $2 after debugging

for priv_groups in  `awk -F'|' '{for(i=1;i<=NF;i++) print $i}' <<< $groups_login`;do
    ROLE_NAME=`awk -F'="' '{print $1}' <<< $priv_groups`
    ROLE_GROUP=$ROLE_NAME

    PRIVILEGES=`awk -F'="' '{gsub(/"/,"", $2); print $2}' <<< $priv_groups`
    PRIVIL_LSTS=`awk -F',' '{for(i=1;i<=NF;i++) print $i}' <<< "$PRIVILEGES"`


    case "$1" in
        "setup")
            # Add role, group and privilege
            priv_formatter g $ROLE_NAME, $ROLE_GROUP

            $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --create_role -r $ROLE_NAME
            $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --add_role_group -r $ROLE_NAME -g $ROLE_GROUP

            for PRIVIL in $PRIVIL_LSTS; do
                $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --grant_privilege_role --rolename $ROLE_NAME --privilege $PRIVIL
            done
            ;;
        "clean")
            # Remove role, group and privilege
            priv_formatter r $ROLE_NAME, $ROLE_GROUP

            for PRIVIL in $PRIVIL_LSTS; do
                $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --revoke_privilege_role -r $ROLE_NAME -p $PRIVIL
            done

            $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --delete_role_group -r $ROLE_NAME -g $ROLE_GROUP
            $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --drop_role -r $ROLE_NAME
            ;;
        "check")
            # Check role, group and privilege
            priv_formatter c $ROLE_NAME, $ROLE_GROUP

            # Too many roles and temporary comment the line.
            #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_role
            $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_role -g $ROLE_GROUP
            $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_privilege -r $ROLE_NAME
            ;;
        * )
        echo "Please specify valid action"
        exit $NOMATCH;;
    esac
done


##============
# set role name and group for specify privilege
USER_ROLE_NAME=hdp_qa_role
USER=hdp_qa

# Additional user related privilege action for role, user and group
rug_priv_all=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[ROLE_GROUP_USER_ALL]}"`
##============


# Simply verify that the permission type is valid
: ${privil_type_ug:="proxy_user_group1"}

if [[ "$privil_type_ug" == "proxy_user_group2" ]]; then
    case "$1" in
        "setup")
            # Add user related privilege
            priv_formatter g $USER_ROLE_NAME, $USER

            $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -create_role -r $USER_ROLE_NAME
            $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -add_role_user -r $USER_ROLE_NAME -u $USER

            for privil in $rug_priv_all; do
                $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -grant_privilege_role --rolename $USER_ROLE_NAME --privilege "$privil"
            done
            ;;
        "clean")
            # Remove user related privilege
            priv_formatter r $USER_ROLE_NAME, $USER

            for privil in $rug_priv_all; do
                $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -revoke_privilege_role --rolename $USER_ROLE_NAME --privilege "$privil"
            done

            $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -delete_role_user -r $USER_ROLE_NAME -u $USER
            $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml -drop_role -r $USER_ROLE_NAME
            ;;
        "check")
            # Check role, group and privilege
            priv_formatter c $USER_ROLE_NAME, $USER

            # Too many roles and temporary comment the line.
            #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_role
            $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_privilege -r $USER_ROLE_NAME
            $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_role -u $USER
            ;;
        * )
            echo "Please specify valid action"
            exit $NOMATCH;;
    esac
fi
