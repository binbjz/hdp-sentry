val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE test_add_columns ADD COLUMNS (id STRING)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE test_add_columns";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
