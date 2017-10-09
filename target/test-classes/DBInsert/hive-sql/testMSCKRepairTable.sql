--Precondition:
CREATE DATABASE test_db2;
CREATE TABLE test_db2.test_msck (id INT, val STRING) PARTITIONED BY(month INT);

--Execution:
SHOW PARTITIONS test_db2.test_msck;

--创建两个分区目录
dfs -mkdir /user/hive/warehouse/test_db2.db/test_msck/month=201603;
dfs -mkdir /user/hive/warehouse/test_db2.db/test_msck/month=201604;

--使用MSCK修复分区
MSCK REPAIR TABLE test_db2.test_msck;

--再次查看，发现已经成功更新元信息
SHOW PARTITIONS test_db2.test_msck;
dfs -ls /user/hive/warehouse/test_db2.db/test_msck;

--Cleanup:
DROP TABLE test_db2.test_msck;
DROP DATABASE test_db2 CASCADE;