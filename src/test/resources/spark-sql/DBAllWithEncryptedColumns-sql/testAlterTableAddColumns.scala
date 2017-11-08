--encrypt_db4alter.tbl4addcolumn=encrypt_col2
--CREATE DATABASE encrypt_db4alter;
--DROP DATABASE encrypt_db4alter;

val test_sql="USE encrypt_db4alter";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE TABLE tbl4addcolumn (col1 TINYINT, encrypt_col2 BIGINT, col3 STRING)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="INSERT INTO tbl4addcolumn VALUES (1, 2, 3), (2, 4, 6)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE tbl4addcolumn ADD COLUMNS (id STRING)";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DESC tbl4addcolumn";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT id FROM tbl4addcolumn";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT col1, encrypt_col2, col3 FROM tbl4addcolumn";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM tbl4addcolumn";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE tbl4addcolumn";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
