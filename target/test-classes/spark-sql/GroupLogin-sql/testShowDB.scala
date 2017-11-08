val test_sql="USE default";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW DATABASES";
spark.sql(test_sql).collect().foreach(println);

System.exit(0)
