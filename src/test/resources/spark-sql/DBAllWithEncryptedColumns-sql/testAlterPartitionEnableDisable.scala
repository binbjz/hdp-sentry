//encrypt_db4alter.test_enable_disable_partition=encrypt_message
//CREATE DATABASE encrypt_db4alter;
//DROP DATABASE encrypt_db4alter;

val test_sql="USE encrypt_db4alter";
spark.sql(test_sql).collect().foreach(println);
val test_sql="""CREATE TABLE IF NOT EXISTS encrypt_db4alter.test_enable_disable_partition (hms INT, severity STRING, server STRING, process_id INT, encrypt_message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE encrypt_db4alter.test_enable_disable_partition ADD PARTITION (year=2017, month=8, day=1)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE encrypt_db4alter.test_enable_disable_partition ADD PARTITION (year=2017, month=8, day=2)";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE encrypt_db4alter.test_enable_disable_partition PARTITION(year=2017, month=8, day=1) ENABLE NO_DROP";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE encrypt_db4alter.test_enable_disable_partition DROP PARTITION (year=2017, month=8, day=1)";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE encrypt_db4alter.test_enable_disable_partition PARTITION(year=2017, month=8, day=1) DISABLE NO_DROP";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE encrypt_db4alter.test_enable_disable_partition DROP PARTITION (year=2017, month=8, day=1)";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE encrypt_db4alter.test_enable_disable_partition PARTITION(year=2017, month=8, day=2) ENABLE OFFLINE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE encrypt_db4alter.test_enable_disable_partition DROP PARTITION (year=2017, month=8, day=2)";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE encrypt_db4alter.test_enable_disable_partition PARTITION(year=2017, month=8, day=2) DISABLE OFFLINE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE encrypt_db4alter.test_enable_disable_partition DROP PARTITION (year=2017, month=8, day=2)";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE encrypt_db4alter.test_enable_disable_partition";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
