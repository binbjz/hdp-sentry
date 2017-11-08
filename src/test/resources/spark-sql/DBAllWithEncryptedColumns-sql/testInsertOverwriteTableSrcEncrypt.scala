--encrypt_db4data.table_src=name
--CREATE DATABASE encrypt_db4data;
--DROP DATABASE encrypt_db4data;

val test_sql="USE encrypt_db4data";
spark.sql(test_sql).collect().foreach(println);
val test_sql='''CREATE TABLE encrypt_db4data.table_src (name STRING, ip STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t"''';
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT INTO encrypt_db4data.table_src VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2'), ('alibaba', '10.0.0.3')";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);

val test_sql="CREATE TABLE IF NOT EXISTS encrypt_db4data.table002 LIKE encrypt_db4data.table_src";
spark.sql(test_sql).collect().foreach(println);
val test_sql="INSERT OVERWRITE TABLE encrypt_db4data.table002 SELECT name, ip FROM encrypt_db4data.table_src WHERE name='meituan'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM encrypt_db4data.table002";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT OVERWRITE TABLE encrypt_db4data.table002 SELECT * FROM encrypt_db4data.table_src";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM encrypt_db4data.table002";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT ROW_NUMBER() OVER(PARTITION BY ip ORDER BY ip DESC) ID, name, ip FROM encrypt_db4data.table002";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE encrypt_db4data.table_src";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE encrypt_db4data.table002";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
