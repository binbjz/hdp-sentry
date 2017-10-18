--encrypt_db4alter.log_messages=encrypt_hms,encrypt_severity,encrypt_server,encrypt_process_id,encrypt_message
--CREATE DATABASE encrypt_db4alter;
--DROP DATABASE encrypt_db4alter;

USE encrypt_db4alter;
CREATE TABLE IF NOT EXISTS encrypt_db4alter.log_messages (encrypt_hms INT, encrypt_severity STRING, encrypt_server STRING, encrypt_process_id INT, encrypt_message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
ALTER TABLE encrypt_db4alter.log_messages ADD PARTITION (year = 2011, month = 1, day = 1);
ALTER TABLE encrypt_db4alter.log_messages ADD PARTITION (year = 2011, month = 1, day = 2);

dfs -ls /user/hive/warehouse/encrypt_db4alter.db/log_messages/year=2011/month=1/day=1;
dfs -ls /user/hive/warehouse/encrypt_db4alter.db/log_messages/year=2011/month=1/day=2;

dfs -mkdir -p /user/hive/warehouse/encrypt_db4alter.db/log_messages_new/year=2011/month=1/day=2;

ALTER TABLE encrypt_db4alter.log_messages PARTITION (year = 2011, month = 1, day = 2) SET LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/encrypt_db4alter.db/log_messages_new/year=2011/month=1/day=2';
--获取table的真实hdfs路径
DESC FORMATTED encrypt_db4alter.log_messages;
--获取partition的真实hdfs路径
DESC FORMATTED encrypt_db4alter.log_messages partition (year = 2011, month = 1, day =1);
DESC FORMATTED encrypt_db4alter.log_messages partition (year = 2011, month = 1, day =2);
--使用hadoop fs -rmr 命令删除分区的HDFS副本
dfs -rm -r /user/hive/warehouse/encrypt_db4alter.db/log_messages;
dfs -rm -r /user/hive/warehouse/encrypt_db4alter.db/log_messages_new;

DROP TABLE encrypt_db4alter.log_messages;