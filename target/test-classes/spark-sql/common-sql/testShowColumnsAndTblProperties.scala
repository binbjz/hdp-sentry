val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SHOW TBLPROPERTIES employees_props";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS IN employees_props";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS FROM employees_props";
spark.sql(test_sql).collect().foreach(println);

:q
