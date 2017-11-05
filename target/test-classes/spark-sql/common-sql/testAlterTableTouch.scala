val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE tbl4analyze TOUCH";
spark.sql(test_sql).collect().foreach(println);

:q
