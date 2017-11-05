val test_sql="USE default";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER DATABASE default SET DBPROPERTIES ('edited-by' = 'hadoop-new-qa')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE DATABASE EXTENDED default";
spark.sql(test_sql).collect().foreach(println);

:q
