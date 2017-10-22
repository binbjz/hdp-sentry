SHOW PARTITIONS testdb.test_msck;
dfs -mkdir /user/hive/warehouse/testdb.db/test_msck/month=201603;
dfs -mkdir /user/hive/warehouse/testdb.db/test_msck/month=201604;
MSCK REPAIR TABLE testdb.test_msck;
SHOW PARTITIONS testdb.test_msck;
dfs -ls /user/hive/warehouse/testdb.db/test_msck/month=201603;
