val test_sql="USE default";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SHOW DATABASES LIKE 'origin_waimai'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP DATABASE origin_waimai";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP DATABASE dim";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW DATABASES LIKE 'origin_waimai'";
spark.sql(test_sql).collect().foreach(println);

System.exit(0)
