//encrypt_db4alter.tbl4rename=encrypt_col3
//CREATE DATABASE encrypt_db4alter;
//DROP DATABASE encrypt_db4alter;

val test_sql="USE encrypt_db4alter";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE TABLE tbl4rename (col1 TINYINT, col2 SMALLINT, encrypt_col3 INT)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM tbl4rename";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT col1, col2, encrypt_col3 FROM tbl4rename";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE tbl4rename RENAME TO tbl4rename_new";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM tbl4rename_new";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT col1, col2, encrypt_col3 FROM tbl4rename_new";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE tbl4rename_new";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
