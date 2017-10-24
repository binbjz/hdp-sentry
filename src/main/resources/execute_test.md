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