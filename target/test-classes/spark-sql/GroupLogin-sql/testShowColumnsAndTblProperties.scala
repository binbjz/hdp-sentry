val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TBLPROPERTIES mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS IN mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS FROM mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
