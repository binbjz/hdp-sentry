val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE tbl4rename SET TBLPROPERTIES ('notes' = 'Test for set tblproperties')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TBLPROPERTIES tbl4rename";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE tbl4rename RENAME TO tbl4rename_new";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TABLES LIKE 'tbl4rename*'";
spark.sql(test_sql).collect().foreach(println);

:q
