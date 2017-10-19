#!/bin/bash
#filename: hive_env.sh
#
#The script will define three different types of authentication
#

# Define param and env for hive
ARGS=2
BAD_PARAMS=65
NOMATCH=126
NOPRI=62
HIVE_HOME=`readlink -f /opt/meituan/hive-1.2`


# Check CLI parameter
[ $# -ne $ARGS ] && echo "Usage: `basename $BASH_SOURCE` (keytab_auth|proxy_user|proxy_user_group|clean_proxy_user) (super|normal|hive)" && exit $BAD_PARAMS

# set proxy user for specify privilege
if [[ "$2" == "super" ]]; then
    PROXY_USER=mt_qa
elif [[ "$2" == "normal" ]]; then
    PROXY_USER=hdp_qa
elif [[ "$2" == "hive" ]]; then
    :
else
    echo "Please specify valid sentry privilege"
    exit $NOPRI
fi

# Select the corresponding authentication type
case "$1" in
"keytab_auth")
    #keytab authentication
    source /opt/meituan/hadoop/bin/hadoop_user_login.sh $PROXY_USER
    ;;
"proxy_user")
    #proxy user
    export HADOOP_HOME=/opt/meituan/hadoop
    export HIVE_HOME=$HIVE_HOME
    export HADOOP_JAR_AUTHENTICATION=KERBEROS
    export HADOOP_JAR_KERBEROS_KEYTAB_FILE=/etc/hadoop/keytabs/hadoop-launcher.keytab
    export HADOOP_JAR_KERBEROS_PRINCIPAL=hadoop-launcher/_HOST@SANKUAI.COM
    export HADOOP_PROXY_USER=$PROXY_USER
    ;;
"clean_proxy_user")
    #proxy user
    unset HADOOP_JAR_AUTHENTICATION
    unset HADOOP_JAR_KERBEROS_KEYTAB_FILE
    unset HADOOP_JAR_KERBEROS_PRINCIPAL
    unset HADOOP_PROXY_USER
    ;;
"proxy_user_group")
    #role, group and privilege
    #export HADOOP_PROXY_USER=hadoop-qa/misid@group1,group2
    :
;;
* )
    echo "Please specify valid authentication type"
    exit $NOMATCH;;
esac
