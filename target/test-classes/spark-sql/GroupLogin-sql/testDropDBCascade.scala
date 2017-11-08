val test_sql="USE default";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SHOW DATABASES LIKE 'origin_waimai'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW DATABASES LIKE 'origin_waimai_crm'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP DATABASE origin_waimai CASCADE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP DATABASE mart_waimai_crm CASCADE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW DATABASES LIKE 'origin_waimai'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW DATABASES LIKE 'origin_waimai_crm'";
spark.sql(test_sql).collect().foreach(println);

System.exit(0)
