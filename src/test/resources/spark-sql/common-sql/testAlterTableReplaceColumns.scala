val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE tbl4replacecolumns REPLACE COLUMNS (new_col1 INT COMMENT 'new column 1')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE tbl4replacecolumns";
spark.sql(test_sql).collect().foreach(println);

:q
