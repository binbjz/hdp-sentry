DROP DATABASE IF EXISTS db4alter CASCADE;
CREATE DATABASE db4alter;

USE db4alter;

CREATE TABLE IF NOT EXISTS db4alter.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE db4alter.log_messages ADD PARTITION (year = 2011, month = 1, day = 1);
ALTER TABLE db4alter.log_messages ADD PARTITION (year = 2011, month = 1, day = 2);

dfs -ls /user/hive/warehouse/db4alter.db/log_messages/year=2011/month=1/day=1;
dfs -ls /user/hive/warehouse/db4alter.db/log_messages/year=2011/month=1/day=2;
dfs -mkdir -p /user/hive/warehouse/db4alter.db/log_messages_new/year=2011/month=1/day=2;

--更改TABLE以将分区指向新位置
ALTER TABLE db4alter.log_messages PARTITION (year = 2011, month = 1, day = 2) SET LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/db4alter.db/log_messages_new/year=2011/month=1/day=2';

--获取table的真实hdfs路径
DESC FORMATTED db4alter.log_messages;

--获取partition的真实hdfs路径
DESC FORMATTED db4alter.log_messages partition (year = 2011, month = 1, day =1);
DESC FORMATTED db4alter.log_messages partition (year = 2011, month = 1, day =2);

dfs -rm -r /user/hive/warehouse/db4alter.db/log_messages;
dfs -rm -r /user/hive/warehouse/db4alter.db/log_messages_new;

DROP TABLE db4alter.log_messages;
DROP DATABASE db4alter;
