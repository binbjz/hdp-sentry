USE testdb;

SHOW PARTITIONS testdb.test_msck;
-- 创建两个分区目录
dfs -mkdir /user/hive/warehouse/testdb.db/test_msck/month=201603;
dfs -mkdir /user/hive/warehouse/testdb.db/test_msck/month=201604;
-- 使用MSCK修复分区
MSCK REPAIR TABLE testdb.test_msck;
-- 再次查看，发现已经成功更新元信息
SHOW PARTITIONS testdb.test_msck;
dfs -ls -R /user/hive/warehouse/testdb.db/test_msck/month=201603;
dfs -ls -R /user/hive/warehouse/testdb.db/test_msck/month=201604;

val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TBLPROPERTIES mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS IN mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS FROM mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);

