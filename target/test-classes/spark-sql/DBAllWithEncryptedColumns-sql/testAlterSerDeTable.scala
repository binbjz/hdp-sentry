--encrypt_db4data.test_serde=encrypt_c0
--CREATE DATABASE encrypt_db4data;
--DROP DATABASE encrypt_db4data;

val test_sql="USE encrypt_db4data";
spark.sql(test_sql).collect().foreach(println);

val test_sql="CREATE TABLE encrypt_db4data.test_serde (encrypt_c0 string, c1 string, c2 string) ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES ('input.regex' = 'bduid\\[(.*)\\]uid\\[(\\d+)\\]uname\\[(.*)\\]', 'output.format.string' = '%1$s\t%2$s') STORED AS TEXTFILE";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE encrypt_db4data.test_serde SET SERDEPROPERTIES ('charset' = 'GBK', 'input.regex'='bduid\\[(.*)\\]uid\\[(\\d+)\\]', 'output.format.string' = '%1$s\t%2$s')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW CREATE TABLE encrypt_db4data.test_serde";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT * FROM encrypt_db4data.test_serde";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE encrypt_db4data.test_serde";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
