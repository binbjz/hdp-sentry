val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi ADD PARTITION (dt=20110102)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi ADD PARTITION (dt=20110103)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi ADD PARTITION (dt=20110104)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW PARTITIONS mart_waimai.dim_ad_cpc_activity_poi";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT ad_activity_key, ad_activity_id, ad_activity_type, poi_id FROM mart_waimai.dim_ad_cpc_activity_poi WHERE dt >= 20110102 AND 20110122 >= dt AND ad_activity_type != 0";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi DROP PARTITION (dt=20110102)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi DROP PARTITION (dt=20110103)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi DROP PARTITION (dt=20110104)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW PARTITIONS mart_waimai.dim_ad_cpc_activity_poi";
spark.sql(test_sql).collect().foreach(println);

:q
