--CREATE DATABASE encrypt_db4drop_cascade;
--DROP DATABASE encrypt_db4drop_cascade;
--encrypt_db4drop_cascade.encrypt_tbl4drop=encrypt_val

val test_sql="USE encrypt_db4drop_cascade";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE TABLE encrypt_tbl4drop (id INT, encrypt_val STRING)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE VIEW encrypt_view4drop AS SELECT * FROM encrypt_db4drop_cascade.encrypt_tbl4drop";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT * FROM encrypt_db4drop_cascade.encrypt_tbl4drop";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM encrypt_db4drop_cascade.encrypt_view4drop";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SHOW TABLES LIKE 'encrypt_*4drop'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP DATABASE encrypt_db4drop_cascade CASCADE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW DATABASES LIKE 'encrypt_db4drop_cascade'";
spark.sql(test_sql).collect().foreach(println);

System.exit(0)
