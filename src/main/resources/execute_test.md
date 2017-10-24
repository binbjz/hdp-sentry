login 
ssh gh-data-hdp-qa03.corp.sankuai.com
sudo -iusankuai

1. su to root
$ sudo less /opt/meituan/log_agent/logs/log_agent.info
!

2.
rm -rf /opt/meituan/qa_test/sentry-test

3. exit to jinxin02
exit

4. clone code to jinxin02 directory
git clone ssh://git@git.sankuai.com/~zhaobin11/sentry-test.git

5. su to root
sudo -iu sankuai
$ sudo less /opt/meituan/log_agent/logs/log_agent.info
!

6. copy directory to /opt/meituan/qa_test
\cp -rp /home/zhaobin11/sentry-test /opt/meituan/qa_test/

8. change own to sankuai
chown sankuai:sankuai -R /opt/meituan/qa_test/sentry-test

9. cd sentry-test with sankuai user
cd /opt/meituan/qa_test/sentry-test

10.
git branch -a -vv
git checkout -b sentry_bin --track origin/sentry_bin

11. change own with root
chown sankuai:sankuai -R /opt/meituan/qa_test/sentry-test

execute command:
1. grant mt_qa privilege to super
source /opt/meituan/qa_test/sentry-test/src/main/resources/sentry_env.sh (setup|check|clean) SuperPrivil

2. grant mt_qa privilege to ServerAlter (hdp_Qa)
source /opt/meituan/qa_test/sentry-test/src/main/resources/sentry_env.sh (setup|check|clean) ServerAlter

3. login hive shell with mt_qa to execute prepare sql
source /opt/meituan/qa_test/sentry-test/src/main/resources/hive_env.sh proxy_user super
echo $HADOOP_PROXY_USER

/opt/meituan/hive-1.2/bin/hive --hiveconf hive.cli.errors.ignore=true -f /opt/meituan/qa_test/sentry-test/src/test/resources/ServerAlter/hive-sql/prepareServerAlter.sql

4. login hive shell with hdp_qa execute test case
source /opt/meituan/qa_test/sentry-test/src/main/resources/hive_env.sh proxy_user normal
echo $HADOOP_PROXY_USER

/usr/bin/time -f "Time: %U" java -Djava.ext.dirs=/opt/meituan/qa_test/data_bin/ -cp /opt/meituan/qa_test/sentry-test/target/classes:/opt/meituan/qa_test/sentry-test/target/test-classes/ org.junit.runner.JUnitCore ServerAlter


##==revoke sentry privilege
source /opt/meituan/qa_test/sentry-test/src/main/resources/hive_env.sh clean_proxy_user hive


##======all log
less src/test/log/sentry_debug.log
/opt/meituan/qa_test/sentry-test/src/test/resources/ServerAlter/hive-output/*

##=====run script
cd /opt/meituan/qa_test/sentry-test/
bash run_sentry_tcs.sh


update external ini files
copy new ini file to sentry server by misid
[lijinxin02@gh-data-hdp-qa03 resources]$ scp external.ini lijinxin02@gh-data-hdp-qa03.corp.sankuai.com:/tmp
lijinxin02@gh-data-hdp-qa03.corp.sankuai.com's password:
external.ini                                                                  100% 3454     3.4KB/s   00:00
[lijinxin02@gh-data-hdp-qa03 resources]$ scp external.ini lijinxin02@gh-data-hdp-qa04.corp.sankuai.com:/tmp
lijinxin02@gh-data-hdp-qa04.corp.sankuai.com's password:
external.ini                                                                  100% 3454     3.4KB/s   00:00
[lijinxin02@gh-data-hdp-qa03 resources]$ scp external.ini lijinxin02@gh-data-hdp-qa05.corp.sankuai.com:/tmp

update ini file
[sankuai@gh-data-hdp-qa04.corp.sankuai.com:/opt/meituan/sentry/conf]$ cp /tmp/external.ini external.ini
cp: overwrite `external.ini'? yes

restart hms and sentry service
sentry服务的重启：在dx-data-hive-metastore01切到sankuai用户，执行sudo svc -t /service/meituan.data.hadoop.sentry
跟sentry类似，重启HMS：sudo svc -t /service/meituan.data.hive.hive/




---HIVE CLIENT

sudo -iusankuai
export HADOOP_JAR_AUTHENTICATION=KERBEROS
export HADOOP_JAR_KERBEROS_KEYTAB_FILE=/etc/hadoop/keytabs/hadoop-launcher.keytab
export HADOOP_JAR_KERBEROS_PRINCIPAL=hadoop-launcher/_HOST@SANKUAI.COM
export HADOOP_PROXY_USER=server_all
/opt/meituan/hive-1.2/bin/hive




sudo -iusankuai
export HADOOP_JAR_AUTHENTICATION=KERBEROS
export HADOOP_JAR_KERBEROS_KEYTAB_FILE=/etc/hadoop/keytabs/hadoop-launcher.keytab
export HADOOP_JAR_KERBEROS_PRINCIPAL=hadoop-launcher/_HOST@SANKUAI.COM
export HADOOP_PROXY_USER=hdp_qa/hdp_qa@ba_ups_group,dim_group,dw_group,mart_waimai_group,mart_waimai_crm_group,mart_wmorg_group,origin_waimai_group,origindb_group,origindb_delta_group,origin_dianping_group



hdp_qa=hdp_qa,ba_ups_group,dim_group,dw_group,mart_waimai_group,mart_waimai_crm_group,mart_wmorg_group,origin_waimai_group,origindb_group,origindb_delta_group,origin_dianping_group





java -cp .:./junit.jar:./sentry_test.jar:./hamcrest-core-1.3.jar org.junit.runner.JUnitCore TestServerAll



hadoop-launcher.keytab
export HADOOP_JAR_KERBEROS_KEYTAB_FILE=/etc/hadoop/keytabs/hadoop-launcher.keytab
export HADOOP_JAR_KERBEROS_PRINCIPAL=hadoop-launcher/_HOST@SANKUAI.COM
export HADOOP_PROXY_USER=server_all


方式与proxy user基本相同，只是proxy user指定了具体的激活组
具体写法为export HADOOP_PROXY_USER=hadoop-qa/misid@group1,group2
其中group名称可以有多个，以逗号分隔；如果指定的激活组不是user对应的有效组，会直接抛出异常



---SENTRY SHELL
sudo -iusankuai
export HADOOP_HOME=/opt/meituan/hadoop
export HIVE_HOME=/opt/meituan/hive-1.2
source /opt/meituan/hadoop/bin/hadoop_user_login.sh hive


  
Add role, group and privilege

/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -create_role -r column_all
/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -add_role_group -r column_all -g column_all_group
/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --role column_all --privilege "server=server1->db=test_db->table=test_tbl->column=a->action=all"


Remove role, group and privilege

/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --revoke_privilege_role -r column_all -p "server=server1->db=test_db->table=test_tbl->column=a->action=all"
/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --delete_role_group -r column_all -g column_all_group
/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --drop_role -r column_all



Check role, group and privilege

/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --list_role
/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --list_role -g column_all_group
/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --list_privilege -r column_all

