//encrypt_db4data.partition_table_src=ip
//CREATE DATABASE encrypt_db4data;
//DROP DATABASE encrypt_db4data;

USE encrypt_db4data;
CREATE TABLE encrypt_db4data.partition_table_src (name STRING, ip STRING)
PARTITIONED BY (dt STRING, ht STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";

INSERT INTO encrypt_db4data.partition_table_src PARTITION (dt='20150617', ht='00') VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2'), ('alibaba', '10.0.0.3');

dfs -cat /user/hive/warehouse/encrypt_db4data.db/partition_table_src/dt=20150617/ht=00/*;

SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;
SET hive.cli.print.header=true;

CREATE TABLE IF NOT EXISTS encrypt_db4data.partition_table002 LIKE encrypt_db4data.partition_table_src;

INSERT OVERWRITE TABLE encrypt_db4data.partition_table002 PARTITION (dt='20150617', ht='00') SELECT name, ip FROM encrypt_db4data.partition_table_src WHERE dt='20150617' and ht='00' AND name='meituan';
SELECT * FROM encrypt_db4data.partition_table002;

INSERT OVERWRITE TABLE encrypt_db4data.partition_table002 PARTITION (dt, ht) SELECT * FROM encrypt_db4data.partition_table_src WHERE dt='20150617' AND name='baidu';
SELECT * FROM encrypt_db4data.partition_table002;

INSERT OVERWRITE TABLE encrypt_db4data.partition_table002 PARTITION (dt='20150617', ht) SELECT name, ip, ht FROM encrypt_db4data.partition_table_src WHERE dt='20150617' and ht='00' AND name='alibaba';
SELECT * FROM encrypt_db4data.partition_table002;

DROP TABLE encrypt_db4data.partition_table_src;
DROP TABLE encrypt_db4data.partition_table002;


val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TBLPROPERTIES mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS IN mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS FROM mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
