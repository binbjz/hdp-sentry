--encrypt_db4tbl.tbl4view=encrypt_c1,encrypt_c2
--CREATE DATABASE encrypt_db4tbl;
--DROP DATABASE encrypt_db4tbl;

val test_sql="USE encrypt_db4tbl";
spark.sql(test_sql).collect().foreach(println);

val test_sql="CREATE TABLE encrypt_db4tbl.tbl4view(c0 string, encrypt_c1 string, encrypt_c2 string) PARTITIONED BY (col10 STRING, col20 STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES ('input.regex' = 'bduid\\[(.*)\\]uid\\[(\\d+)\\]uname\\[(.*)\\]', 'output.format.string' = '%1$s\t%2$s') STORED AS TEXTFILE";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE encrypt_db4tbl.tbl4view ADD PARTITION (col10='abc', col20='123')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE EXTENDED encrypt_db4tbl.tbl4view PARTITION (col10='abc', col20='123')";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE encrypt_db4tbl.tbl4view PARTITION (col10='abc', col20='123') SET SERDEPROPERTIES ('charset' = 'GBK', 'input.regex'='bduid\\[(.*)\\]uid\\[(\\d+)\\]', 'output.format.string' = '%1$s\t%2$s')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE EXTENDED encrypt_db4tbl.tbl4view PARTITION (col10='abc', col20='123')";
spark.sql(test_sql).collect().foreach(println);

val test_sql="CREATE VIEW encrypt_db4tbl.view4serde_0 AS SELECT c0, encrypt_c1, encrypt_c2 FROM encrypt_db4tbl.tbl4view";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE VIEW encrypt_db4tbl.view4serde_1 AS SELECT * FROM encrypt_db4tbl.tbl4view";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TABLES LIKE '*4view*'";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE encrypt_db4tbl.tbl4view SET TBLPROPERTIES ('qa comments' = 'test add table properties')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER VIEW encrypt_db4tbl.view4serde_1 SET TBLPROPERTIES ('qa comments' = 'test add view properties')";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT * FROM encrypt_db4tbl.tbl4view";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM encrypt_db4tbl.view4serde_1";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT c0, encrypt_c1, encrypt_c2 FROM encrypt_db4tbl.tbl4view";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT c0, encrypt_c1, encrypt_c2 FROM encrypt_db4tbl.view4serde_1";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SHOW TABLES LIKE '*4view*'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TBLPROPERTIES encrypt_db4tbl.tbl4view";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TBLPROPERTIES encrypt_db4tbl.view4serde_1";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SHOW CREATE TABLE encrypt_db4tbl.tbl4view";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE encrypt_db4tbl.tbl4view";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP VIEW encrypt_db4tbl.view4serde_0";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP VIEW encrypt_db4tbl.view4serde_1";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TABLES LIKE '*4view*'";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
