val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi PARTITION (dt = 20110122) ENABLE NO_DROP";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi DROP PARTITION (dt = 20110122)";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi PARTITION (dt = 20110122) DISABLE NO_DROP";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi DROP PARTITION (dt = 20110122)";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi PARTITION (dt = 20110123) ENABLE OFFLINE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi DROP PARTITION (dt = 20110123)";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi PARTITION (dt = 20110123) DISABLE OFFLINE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi DROP PARTITION (dt = 20110123)";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
