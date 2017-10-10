SHOW PARTITIONS test_db.test_msck;
--#创建两个分区目录
dfs -mkdir /user/hive/warehouse/test_db.db/test_msck/month=201603;
dfs -mkdir /user/hive/warehouse/test_db.db/test_msck/month=201604;

--#使用MSCK修复分区
MSCK REPAIR TABLE test_db08.test_msck;

--#再次查看，发现已经成功更新元信息
SHOW PARTITIONS test_db08.test_msck;
dfs -ls /user/hive/warehouse/test_db08.db/test_msck/month=201603;
dfs -ls /user/hive/warehouse/test_db08.db/test_msck/month=201604;
dfs -rm -r /user/hive/warehouse/test_db08.db/test_msck;
