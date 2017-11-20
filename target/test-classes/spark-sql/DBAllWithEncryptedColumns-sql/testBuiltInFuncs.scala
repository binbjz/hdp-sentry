//encrypt_db4data.tbl4builtinfuncs=encrypt_col2,encrypt_col3
//CREATE DATABASE encrypt_db4data;
//DROP DATABASE encrypt_db4data;

val test_sql="USE encrypt_db4data";
spark.sql(test_sql).collect().foreach(println);

val test_sql="CREATE TABLE IF NOT EXISTS tbl4builtinfuncs (col1 STRING, encrypt_col2 STRING, encrypt_col3 STRING)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="INSERT INTO tbl4builtinfuncs VALUES ('lower', 'ab', 'cd,ab,ef'), ('Mixed', 'ab,ef', 'cd,ab,ef'), ('UPPER', 'abc', 'cd,ab,ef')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT repeat(encrypt_col2,2) repeat FROM tbl4builtinfuncs";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT ascii(encrypt_col2) ascii FROM tbl4builtinfuncs";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT lpad(col1, 12, encrypt_col2) lpad FROM tbl4builtinfuncs";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT split(encrypt_col3, ',') split FROM tbl4builtinfuncs";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT find_in_set(encrypt_col2, encrypt_col3) find_in_set FROM tbl4builtinfuncs";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE tbl4builtinfuncs";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
