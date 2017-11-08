val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi SET SERDEPROPERTIES ('charset' = 'GBK', 'input.regex'='bduid\\[(.*)\\]uid\\[(\\d+)\\]', 'output.format.string' = '%1$s\t%2$s')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW CREATE TABLE mart_waimai.dim_ad_cpc_activity_poi";
spark.sql(test_sql).collect().foreach(println);

System.exit(0)
