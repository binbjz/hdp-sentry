//encrypt_db4data.partition_table_tgt=name
//CREATE DATABASE encrypt_db4data;
//DROP DATABASE encrypt_db4data;

val test_sql="USE encrypt_db4data";
spark.sql(test_sql).collect().foreach(println);
val test_sql='''CREATE TABLE encrypt_db4data.partition_table001 (name STRING, ip STRING)
PARTITIONED BY (dt STRING, ht STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t"''';
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT INTO encrypt_db4data.partition_table001 PARTITION (dt='20150617', ht='00') VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2'), ('alibaba', '10.0.0.3')";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET hive.exec.dynamic.partition=true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.exec.dynamic.partition.mode=nonstrict";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);

val test_sql="CREATE TABLE IF NOT EXISTS encrypt_db4data.partition_table_tgt LIKE encrypt_db4data.partition_table001";
spark.sql(test_sql).collect().foreach(println);
val test_sql="INSERT OVERWRITE TABLE encrypt_db4data.partition_table_tgt PARTITION (dt='20150617', ht='00') SELECT name, ip FROM encrypt_db4data.partition_table001 WHERE dt='20150617' and ht='00' AND name='meituan'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT COUNT(*) row_count FROM encrypt_db4data.partition_table_tgt";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM encrypt_db4data.partition_table_tgt";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT OVERWRITE TABLE encrypt_db4data.partition_table_tgt PARTITION (dt, ht) SELECT * FROM encrypt_db4data.partition_table001 WHERE dt='20150617' AND name='baidu'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT COUNT(*) row_count FROM encrypt_db4data.partition_table_tgt";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM encrypt_db4data.partition_table_tgt";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT OVERWRITE TABLE encrypt_db4data.partition_table_tgt PARTITION (dt='20150617', ht) SELECT name, ip, ht FROM encrypt_db4data.partition_table001 WHERE dt='20150617' and ht='00' AND name='alibaba'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT COUNT(*) row_count FROM encrypt_db4data.partition_table_tgt";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM encrypt_db4data.partition_table_tgt";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE encrypt_db4data.partition_table001";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE encrypt_db4data.partition_table_tgt";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
