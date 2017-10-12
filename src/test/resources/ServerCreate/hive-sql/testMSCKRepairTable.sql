CREATE TABLE test_msck (id INT, val STRING) PARTITIONED BY(month INT);
SHOW PARTITIONS test_msck;
--创建两个分区目录
dfs -mkdir /user/hive/warehouse/test_msck/month=201603;
dfs -mkdir /user/hive/warehouse/test_msck/month=201604;
--使用MSCK修复分区
MSCK REPAIR TABLE default.test_msck;
