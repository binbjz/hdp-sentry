val test_sql="USE default";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP DATABASE db4drop";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW DATABASES LIKE 'db4drop'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP DATABASE db4drop_cascade";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW DATABASES LIKE 'db4drop*'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP DATABASE db4drop_cascade CASCADE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW DATABASES LIKE 'db4drop*'";
spark.sql(test_sql).collect().foreach(println);

:q
