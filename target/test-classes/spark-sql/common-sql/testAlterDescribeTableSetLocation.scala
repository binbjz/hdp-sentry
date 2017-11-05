USE testdb;

dfs -mkdir /user/hive/warehouse/testdb.db/tbl4setlocation_new;
--获取table的真实hdfs路径
DESC FORMATTED testdb.tbl4setlocation;
ALTER TABLE testdb.tbl4setlocation SET LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb.db/tbl4setlocation_new';
DESC FORMATTED testdb.tbl4setlocation;


val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TBLPROPERTIES mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS IN mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS FROM mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);

:q
