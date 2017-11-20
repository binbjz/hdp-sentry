//encrypt_db4alter.tbl4fileformat=encrypt_server,encrypt_message
//encrypt_db4alter.tbl4fileformat_external=encrypt_server,encrypt_message
//CREATE DATABASE encrypt_db4alter;
//DROP DATABASE encrypt_db4alter;

USE encrypt_db4alter;
spark.sql(test_sql).collect().foreach(println);

CREATE TABLE IF NOT EXISTS encrypt_db4alter.tbl4fileformat (hms INT, severity STRING, encrypt_server STRING, process_id INT, encrypt_message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
spark.sql(test_sql).collect().foreach(println);
ALTER TABLE encrypt_db4alter.tbl4fileformat ADD PARTITION(year = 2011, month = 1, day = 1) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/encrypt_db4alter.db/tbl4fileformat/2011/01/01';
spark.sql(test_sql).collect().foreach(println);
DESCRIBE EXTENDED encrypt_db4alter.tbl4fileformat PARTITION (year = 2011, month = 1, day = 1);
spark.sql(test_sql).collect().foreach(println);

ALTER TABLE encrypt_db4alter.tbl4fileformat PARTITION (year = 2011, month = 1, day = 1) SET FILEFORMAT SEQUENCEFILE;
spark.sql(test_sql).collect().foreach(println);
SHOW PARTITIONS encrypt_db4alter.tbl4fileformat;
DESCRIBE EXTENDED encrypt_db4alter.tbl4fileformat PARTITION (year = 2011, month = 1, day = 1);
spark.sql(test_sql).collect().foreach(println);
ALTER TABLE encrypt_db4alter.tbl4fileformat SET FILEFORMAT SEQUENCEFILE;
spark.sql(test_sql).collect().foreach(println);

SELECT * FROM encrypt_db4alter.tbl4fileformat;
spark.sql(test_sql).collect().foreach(println);

CREATE EXTERNAL TABLE IF NOT EXISTS encrypt_db4alter.tbl4fileformat_external (hms INT, severity STRING, encrypt_server STRING, process_id INT, encrypt_message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
spark.sql(test_sql).collect().foreach(println);
ALTER TABLE encrypt_db4alter.tbl4fileformat_external ADD PARTITION(year = 2011, month = 1, day = 2) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/encrypt_db4alter.db/tbl4fileformat_external/2011/01/02';
spark.sql(test_sql).collect().foreach(println);
DESCRIBE EXTENDED encrypt_db4alter.tbl4fileformat_external PARTITION (year = 2011, month = 1, day = 2);
spark.sql(test_sql).collect().foreach(println);

ALTER TABLE encrypt_db4alter.tbl4fileformat_external PARTITION (year = 2011, month = 1, day = 2) SET FILEFORMAT SEQUENCEFILE;
spark.sql(test_sql).collect().foreach(println);
SHOW PARTITIONS encrypt_db4alter.tbl4fileformat_external;
spark.sql(test_sql).collect().foreach(println);
DESCRIBE EXTENDED encrypt_db4alter.tbl4fileformat_external PARTITION (year = 2011, month = 1, day = 2);
spark.sql(test_sql).collect().foreach(println);
ALTER TABLE encrypt_db4alter.tbl4fileformat_external SET FILEFORMAT SEQUENCEFILE;
spark.sql(test_sql).collect().foreach(println);

SELECT * FROM encrypt_db4alter.tbl4fileformat_external;
spark.sql(test_sql).collect().foreach(println);

DROP TABLE encrypt_db4alter.tbl4fileformat;
spark.sql(test_sql).collect().foreach(println);
DROP TABLE encrypt_db4alter.tbl4fileformat_external;
spark.sql(test_sql).collect().foreach(println);

dfs -rm -r /user/hive/warehouse/encrypt_db4alter.db/tbl4fileformat_external;



val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TBLPROPERTIES mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS IN mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS FROM mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
