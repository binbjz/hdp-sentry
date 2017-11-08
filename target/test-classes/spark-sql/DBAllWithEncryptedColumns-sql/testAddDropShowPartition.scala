--encrypt_db4alter.test_partition=encrypt_quantity
--CREATE DATABASE encrypt_db4alter;
--DROP DATABASE encrypt_db4alter;

val test_sql="USE encrypt_db4alter";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE TABLE encrypt_db4alter.test_partition (id INT, part STRING, encrypt_quantity INT)  PARTITIONED BY (day INT)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE encrypt_db4alter.test_partition ADD PARTITION (day = 20110102)";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SHOW PARTITIONS encrypt_db4alter.test_partition";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT INTO encrypt_db4alter.test_partition PARTITION (day = 20110102) VALUES (1,'100',1),(2,'200',2)";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT id, part, encrypt_quantity FROM encrypt_db4alter.test_partition WHERE day >= 20110102 AND day < 20110103 AND encrypt_quantity < 4";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM encrypt_db4alter.test_partition";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE encrypt_db4alter.test_partition DROP PARTITION (day = 20110102)";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SHOW PARTITIONS encrypt_db4alter.test_partition";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE encrypt_db4alter.test_partition";
spark.sql(test_sql).collect().foreach(println);


System.exit(0)