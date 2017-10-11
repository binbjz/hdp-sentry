CREATE TABLE encrypt_db4msck.test_msck (id INT, val STRING) PARTITIONED BY(month INT);
--创建两个分区目录
dfs -mkdir /user/hive/warehouse/encrypt_db4msck.db/test_msck/month=201603;
dfs -mkdir /user/hive/warehouse/encrypt_db4msck.db/test_msck/month=201604;

--使用MSCK修复分区
MSCK REPAIR TABLE encrypt_db4msck.test_msck;

SELECT id, val FROM encrypt_db4msck.test_msck;

--再次查看，发现已经成功更新元信息
SHOW PARTITIONS encrypt_db4msck.test_msck;
dfs -ls -R /user/hive/warehouse/encrypt_db4msck.db/test_msck/month=201603;
dfs -ls -R /user/hive/warehouse/encrypt_db4msck.db/test_msck/month=201604;
DROP TABLE encrypt_db4msck.test_msck;
