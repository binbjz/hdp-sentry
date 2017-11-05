--encrypt_db4alter.tbl4change=encrypt_col3
--CREATE DATABASE encrypt_db4alter;
--DROP DATABASE encrypt_db4alter;

val test_sql="USE encrypt_db4alter";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE TABLE tbl4change (col1 TINYINT, col2 BIGINT, encrypt_col3 STRING)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM tbl4change";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT col1, col2, encrypt_col3 FROM tbl4change";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT INTO tbl4change VALUES (1, 2, 'column3')"";
spark.sql(test_sql).collect().foreach(println);

val test_sql='ALTER TABLE tbl4change CHANGE col1 col1to2 INT COMMENT "put column1 to position 2nd" AFTER col2';
spark.sql(test_sql).collect().foreach(println);
val test_sql='ALTER TABLE tbl4change CHANGE encrypt_col3 col3to1 INT COMMENT "put last column to position 1st" FIRST';
spark.sql(test_sql).collect().foreach(println);

val test_sql="DESCRIBE tbl4change";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM tbl4change";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE tbl4change";
spark.sql(test_sql).collect().foreach(println);

:q