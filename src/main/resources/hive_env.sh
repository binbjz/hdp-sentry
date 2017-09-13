#!/usr/bin/env bash
#

#set hive env
HIVE_HOME=`readlink -f /opt/meituan/hive-1.2`
USERNAME=hive

sudo -iu sankuai
source /etc/profile

#proxy user
#export HADOOP_JAR_AUTHENTICATION=KERBEROS
#export HADOOP_JAR_KERBEROS_KEYTAB_FILE=/etc/hadoop/keytabs/hadoop-launcher.keytab
#export HADOOP_JAR_KERBEROS_PRINCIPAL=hadoop-launcher/_HOST@SANKUAI.COM
#export HADOOP_PROXY_USER=hadoop-hdp
#export HADOOP_PROXY_USER=hadoop-hdp@hadoop-hdp
#export HADOOP_HOME=/opt/meituan/hadoop

#keytab authentication
source /opt/meituan/hadoop/bin/hadoop_user_login.sh $USERNAME
${HIVE_HOME}/bin/hive