val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE tbl4change CHANGE col1 col1to2 INT COMMENT \"put column1 to position 2nd\" AFTER col2";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE tbl4change CHANGE col3 col3to1 INT COMMENT \"put last column to position 1st\" FIRST";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE tbl4change";
spark.sql(test_sql).collect().foreach(println);

:q
