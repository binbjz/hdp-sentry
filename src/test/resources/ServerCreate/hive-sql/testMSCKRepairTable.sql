CREATE TABLE test_db.test_msck (id INT, val STRING) PARTITIONED BY(month INT);
SHOW PARTITIONS test_db.test_msck;
dfs -mkdir /user/hive/warehouse/test_msck/month=201603;
dfs -mkdir /user/hive/warehouse/test_msck/month=201604;
MSCK REPAIR TABLE test_db.test_msck;
SHOW PARTITIONS test_db.test_msck;
dfs -ls /user/hive/warehouse/test_db.db/test_msck/month=201603;
