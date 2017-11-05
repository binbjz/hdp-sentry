USE testdb;

dfs -ls /user/hive/warehouse/testdb.db/tbl4setlocation/year=2011/month=1/day=1;
dfs -ls /user/hive/warehouse/testdb.db/tbl4setlocation/year=2011/month=1/day=2;

dfs -mkdir -p /user/hive/warehouse/testdb.db/tbl4setlocation_new/year=2011/month=1/day=1;
--更改TABLE以将分区指向新位置：
ALTER TABLE testdb.tbl4setlocation PARTITION (year=2011, month=1, day=1) SET LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb.db/tbl4setlocation_new/year=2011/month=1/day=1';

--获取partition的真实hdfs路径
DESC FORMATTED testdb.tbl4setlocation partition (year=2011, month=1, day=1);
DESC FORMATTED testdb.tbl4setlocation partition (year=2011, month=1, day=2);
--使用hadoop fs -rmr 命令删除分区的HDFS副本：
dfs -rm -r /user/hive/warehouse/testdb.db/tbl4setlocation;
dfs -rm -r /user/hive/warehouse/testdb.db/tbl4setlocation_new;

val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TBLPROPERTIES mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS IN mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS FROM mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);

:q
