--DROP DATABASE IF EXISTS db4msck CASCADE;
--CREATE TABLE db4msck.test_msck (id INT, val STRING) PARTITIONED BY(month INT);
--CREATE DATABASE db4msck;

--DROP TABLE db4msck.test_msck
--DROP DATABASE db4msck CASCADE;

USE db4msck;
SHOW PARTITIONS db4msck.test_msck;
dfs -mkdir /user/hive/warehouse/db4msck.db/test_msck/month=201603;
dfs -mkdir /user/hive/warehouse/db4msck.db/test_msck/month=201604;
MSCK REPAIR TABLE db4msck.test_msck;
SHOW PARTITIONS db4msck.test_msck;
dfs -ls /user/hive/warehouse/db4msck.db/test_msck/month=201603;
