dfs -ls /user/hive/warehouse/testdb.db/log_messages02/year=2011/month=1/day=1;
dfs -ls /user/hive/warehouse/testdb.db/log_messages02/year=2011/month=1/day=2;

dfs -mkdir -p /user/hive/warehouse/testdb.db/log_messages_new02/year=2011/month=1/day=2;
--将要移动的分区的数据复制到新路径
--hadoop distcp 命令：
--hadoop distcp /user/hive/warehouse/testdb.db/log_messages/year=2011/month=1/day=2 /user/hive/warehouse/testdb.db/log_messages_new/year=2011/month=1/day=2;
--更改TABLE以将分区指向新位置：
USE testdb;
ALTER TABLE testdb.log_messages02 PARTITION (year = 2011, month = 1, day = 2) SET LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb.db/log_messages_new02/year=2011/month=1/day=2';
--获取table的真实hdfs路径
DESC FORMATTED testdb.log_messages02;
--获取partition的真实hdfs路径
DESC FORMATTED testdb.log_messages02 partition (year = 2011, month = 1, day =1);
DESC FORMATTED testdb.log_messages02 partition (year = 2011, month = 1, day =2);
--使用hadoop fs -rmr 命令删除分区的HDFS副本
dfs -rm -r /user/hive/warehouse/testdb.db/log_messages02;
dfs -rm -r /user/hive/warehouse/testdb.db/log_messages_new02;
