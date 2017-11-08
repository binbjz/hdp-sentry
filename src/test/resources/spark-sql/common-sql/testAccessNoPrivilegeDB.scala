val test_sql="USE default";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SHOW DATABASES LIKE 'unaccessibledb'";
spark.sql(test_sql).collect().foreach(println);

:q
