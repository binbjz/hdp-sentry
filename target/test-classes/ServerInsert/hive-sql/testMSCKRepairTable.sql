SHOW PARTITIONS db4msck.test_msck;
dfs -mkdir /user/hive/warehouse/db4msck.db/test_msck/month=201603;
dfs -mkdir /user/hive/warehouse/db4msck.db/test_msck/month=201604;
MSCK REPAIR TABLE db4msck.test_msck;
SHOW PARTITIONS db4msck.test_msck;
dfs -ls /user/hive/warehouse/db4msck.db/test_msck/month=201603;
dfs -rm -r /user/hive/warehouse/db4msck.db/test_msck;
