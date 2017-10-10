--Execution:
SHOW PARTITIONS testDB.test_msck;
dfs -mkdir /user/hive/warehouse/testDB.db/test_msck/month=201603;
dfs -mkdir /user/hive/warehouse/testDB.db/test_msck/month=201604;
MSCK REPAIR TABLE testDB.test_msck;
SHOW PARTITIONS testDB.test_msck;
dfs -ls /user/hive/warehouse/testDB.db/test_msck/month=201603;
DROP TABLE testDB.test_msck;
