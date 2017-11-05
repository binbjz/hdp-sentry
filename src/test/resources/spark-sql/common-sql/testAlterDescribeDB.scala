val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER DATABASE testdb SET DBPROPERTIES ('edited-by' = 'hadoop-new-qa')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE DATABASE EXTENDED testdb";
spark.sql(test_sql).collect().foreach(println);

:q
