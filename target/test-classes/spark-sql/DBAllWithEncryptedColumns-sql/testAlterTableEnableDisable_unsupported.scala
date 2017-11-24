//encrypt_db4alter.test_enable_disable=encrypt_message
//CREATE DATABASE encrypt_db4alter;
//DROP DATABASE encrypt_db4alter;

val test_sql="USE encrypt_db4alter";
spark.sql(test_sql).collect().foreach(println);
val test_sql="""CREATE TABLE IF NOT EXISTS encrypt_db4alter.test_enable_disable (hms INT, severity STRING, server STRING, process_id INT, encrypt_message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE encrypt_db4alter.test_enable_disable ENABLE NO_DROP";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE encrypt_db4alter.test_enable_disable";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT * FROM encrypt_db4alter.test_enable_disable";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT server, encrypt_message FROM encrypt_db4alter.test_enable_disable";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE encrypt_db4alter.test_enable_disable DISABLE NO_DROP";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE encrypt_db4alter.test_enable_disable";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""CREATE TABLE IF NOT EXISTS encrypt_db4alter.test_enable_disable (hms INT, severity STRING, server STRING, process_id INT, encrypt_message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE encrypt_db4alter.test_enable_disable ENABLE OFFLINE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE encrypt_db4alter.test_enable_disable";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT * FROM encrypt_db4alter.test_enable_disable";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT server, encrypt_message FROM encrypt_db4alter.test_enable_disable";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE encrypt_db4alter.test_enable_disable DISABLE OFFLINE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE encrypt_db4alter.test_enable_disable";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
