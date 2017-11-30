val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);


/*test Alter Table Add Columns*/

val test_sql="ALTER TABLE tbl4addcolumns ADD COLUMNS (id STRING)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE tbl4addcolumns";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
