DROP DATABASE IF EXISTS testdb CASCADE;
CREATE DATABASE testdb;

USE testdb;

CREATE TABLE IF NOT EXISTS testdb.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE testdb.log_messages ADD PARTITION (year = 2011, month = 1, day = 1);
ALTER TABLE testdb.log_messages ADD PARTITION (year = 2011, month = 1, day = 2);
ALTER TABLE testdb.log_messages ADD PARTITION (year = 2011, month = 2, day = 1);

dfs -ls /user/hive/warehouse/testdb.db/log_messages/year=2011/month=1/day=1;
dfs -ls /user/hive/warehouse/testdb.db/log_messages/year=2011/month=1/day=2;
dfs -ls /user/hive/warehouse/testdb.db/log_messages/year=2011/month=2/day=1;

dfs -mkdir -p /user/hive/warehouse/testdb.db/log_messages_new/year=2011/month=2/day=1;
--将要移动的分区的数据复制到新路径
--hadoop distcp 命令：
--hadoop distcp /user/hive/warehouse/testdb.db/log_messages/year=2011/month=2/day=1 /user/hive/warehouse/testdb.db/log_messages_new/year=2011/month=2/day=1;
--更改TABLE以将分区指向新位置：
ALTER TABLE testdb.log_messages PARTITION (year = 2011, month = 1, day = 1) SET LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb.db/log_messages_new/year=2011/month=1/day=1';
ALTER TABLE testdb.log_messages PARTITION (year = 2011, month = 1, day = 2) SET LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb.db/log_messages_new/year=2011/month=1/day=2';
--获取table的真实hdfs路径
DESC FORMATTED testdb.log_messages;
--获取partition的真实hdfs路径
DESC FORMATTED testdb.log_messages partition (year = 2011, month = 1, day =1);
DESC FORMATTED testdb.log_messages partition (year = 2011, month = 1, day =2);
DESC FORMATTED testdb.log_messages partition (year = 2011, month = 2, day =1);
--使用hadoop fs -rmr 命令删除分区的HDFS副本：
dfs -rm -r /user/hive/warehouse/testdb.db/log_messages/year=2011/month=1/day=1;
dfs -rm -r /user/hive/warehouse/testdb.db/log_messages/year=2011/month=1/day=2;
dfs -rm -r /user/hive/warehouse/testdb.db/log_messages/year=2011/month=2/day=1;

DROP DATABASE testdb CASCADE;
