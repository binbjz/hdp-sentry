SHOW PARTITIONS testdb.test_msck;
--#创建两个分区目录
dfs -mkdir /user/hive/warehouse/testdb.db/test_msck/month=201603;
dfs -mkdir /user/hive/warehouse/testdb.db/test_msck/month=201604;

--#使用MSCK修复分区
<<<<<<< HEAD
MSCK REPAIR TABLE testdb.test_msck;

--#再次查看，发现已经成功更新元信息
SHOW PARTITIONS testdb.test_msck;
dfs -ls /user/hive/warehouse/testdb.db/test_msck/month=201603;
dfs -ls /user/hive/warehouse/testdb.db/test_msck/month=201604;
dfs -rm -r /user/hive/warehouse/testdb.db/test_msck;
=======
MSCK REPAIR TABLE testdb08.test_msck;

--#再次查看，发现已经成功更新元信息
SHOW PARTITIONS testdb08.test_msck;
dfs -ls /user/hive/warehouse/testdb08.db/test_msck/month=201603;
dfs -ls /user/hive/warehouse/testdb08.db/test_msck/month=201604;
dfs -rm -r /user/hive/warehouse/testdb08.db/test_msck;
>>>>>>> b0450854b2f7ed1c2e1b2c8651afe9e2db333a37
