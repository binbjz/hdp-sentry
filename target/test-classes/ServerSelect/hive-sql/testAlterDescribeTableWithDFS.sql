USE testdb;

dfs -ls /user/hive/warehouse/testdb.db/log_messages02/year=2011/month=1/day=1;
dfs -ls /user/hive/warehouse/testdb.db/log_messages02/year=2011/month=1/day=2;

dfs -mkdir -R /user/hive/warehouse/testdb.db/log_messages_new02/year=2011/month=1/day=1;

--更改TABLE以将分区指向新位置：
ALTER TABLE testdb.log_messages02 PARTITION (year = 2011, month = 1, day = 1) SET LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb.db/log_messages_new02/year=2011/month=1/day=1';

--获取table的真实hdfs路径
DESC FORMATTED testdb.log_messages02;
--获取partition的真实hdfs路径
DESC FORMATTED testdb.log_messages02 partition (year = 2011, month = 1, day =1);
DESC FORMATTED testdb.log_messages02 partition (year = 2011, month = 1, day =2);
--使用hadoop fs -rmr 命令删除分区的HDFS副本：
dfs -rm -r /user/hive/warehouse/testdb.db/log_messages02/year=2011/month=1/day=1;
dfs -rm -r /user/hive/warehouse/testdb.db/log_messages02/year=2011/month=1/day=2;
