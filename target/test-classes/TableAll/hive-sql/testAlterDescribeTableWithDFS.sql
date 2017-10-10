ALTER TABLE testDB.log_messages ADD PARTITION (year = 2011, month = 1, day = 1);
ALTER TABLE testDB.log_messages ADD PARTITION (year = 2011, month = 1, day = 2);

dfs -ls /user/hive/warehouse/testDB.db/log_messages/year=2011/month=1/day=1;
dfs -ls /user/hive/warehouse/testDB.db/log_messages/year=2011/month=1/day=2;

dfs -mkdir -p /user/hive/warehouse/testDB.db/log_messages_new/year=2011/month=1/day=1;
--更改TABLE以将分区指向新位置：
USE testDB;
ALTER TABLE testDB.log_messages PARTITION (year = 2011, month = 1, day = 1) SET LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testDB.db/log_messages_new/year=2011/month=1/day=1';
--获取table的真实hdfs路径
DESC FORMATTED testDB.log_messages;
--获取partition的真实hdfs路径
DESC FORMATTED testDB.log_messages partition (year = 2011, month = 1, day =1);
DESC FORMATTED testDB.log_messages partition (year = 2011, month = 1, day =2);
--使用hadoop fs -rmr 命令删除分区的HDFS副本：
dfs -rm -r /user/hive/warehouse/testDB.db/log_messages/year=2011/month=1/day=1;
DROP TABLE testDB.log_messages;
dfs -rm -r /user/hive/warehouse/testDB.db/log_messages_new;
