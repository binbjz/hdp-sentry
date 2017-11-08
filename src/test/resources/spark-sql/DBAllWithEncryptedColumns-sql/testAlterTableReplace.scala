--encrypt_db4alter.tbl4replace=encrypt_col2,encrypt_col3
--CREATE DATABASE encrypt_db4alter;
--DROP DATABASE encrypt_db4alter;

val test_sql="USE encrypt_db4alter";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE TABLE tbl4replace (col1 TINYINT, encrypt_col2 BIGINT, encrypt_col3 STRING)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="INSERT INTO tbl4replace VALUES (1, 2, 'column 3')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM tbl4replace";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE tbl4replace REPLACE COLUMNS (new_col1 INT COMMENT 'new column 1' , new_col2 STRING COMMENT 'new column 2', new_col3 STRING COMMENT 'new column3')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM tbl4replace";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT new_col1, new_col2, new_col3 FROM tbl4replace";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE tbl4replace";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE tbl4replace";
spark.sql(test_sql).collect().foreach(println);

System.exit(0)
