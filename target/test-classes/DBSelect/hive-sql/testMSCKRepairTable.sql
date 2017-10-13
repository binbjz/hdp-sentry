-- 创建两个分区目录
dfs -mkdir /user/hive/warehouse/testdb.db/test_msck/month=201603;
dfs -mkdir /user/hive/warehouse/testdb.db/test_msck/month=201604;
-- 使用MSCK修复分区
MSCK REPAIR TABLE testdb.test_msck;
-- 再次查看，发现已经成功更新元信息
SHOW PARTITIONS testdb.test_msck;
dfs -ls -R /user/hive/warehouse/testdb.db/test_msck/month=201603;
dfs -ls -R /user/hive/warehouse/testdb.db/test_msck/month=201604;
