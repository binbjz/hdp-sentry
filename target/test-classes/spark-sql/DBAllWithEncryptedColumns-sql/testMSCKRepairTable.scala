--encrypt_db4msck.test_msck=encrypt_val
--CREATE DATABASE encrypt_db4msck;
--DROP DATABASE encrypt_db4msck;

USE encrypt_db4msck;
CREATE TABLE encrypt_db4msck.test_msck (id INT, encrypt_val STRING) PARTITIONED BY(month INT);
ALTER TABLE encrypt_db4msck.test_msck ADD PARTITION (month=201602);
INSERT INTO encrypt_db4msck.test_msck PARTITION (month=201602) VALUES (1, 'encrypt value1'), (2, 'encrypt value2');

--创建两个分区目录
dfs -mkdir /user/hive/warehouse/encrypt_db4msck.db/test_msck/month=201603;
dfs -mkdir /user/hive/warehouse/encrypt_db4msck.db/test_msck/month=201604;

--使用MSCK修复分区
MSCK REPAIR TABLE encrypt_db4msck.test_msck;

SELECT id, encrypt_val, month FROM encrypt_db4msck.test_msck;
SELECT COUNT(*) FROM encrypt_db4msck.test_msck;

--再次查看，发现已经成功更新元信息
SHOW PARTITIONS encrypt_db4msck.test_msck;
dfs -ls -R /user/hive/warehouse/encrypt_db4msck.db/test_msck/month=201603;
dfs -ls -R /user/hive/warehouse/encrypt_db4msck.db/test_msck/month=201604;
DROP TABLE encrypt_db4msck.test_msck;

val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TBLPROPERTIES mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS IN mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS FROM mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);

