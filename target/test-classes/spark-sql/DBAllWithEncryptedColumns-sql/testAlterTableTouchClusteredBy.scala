//encrypt_db4data.test_clusteredby=encrypt_salary,encrypt_address
//CREATE DATABASE encrypt_db4data;
//DROP DATABASE encrypt_db4data;

USE encrypt_db4data;

CREATE TABLE encrypt_db4data.test_clusteredby (
 name STRING
,encrypt_salary FLOAT
,subordinates ARRAY<STRING>
,deductions MAP<STRING, FLOAT>
,encrypt_address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE encrypt_db4data.test_clusteredby
PARTITION (country = 'US', state = 'CA');

dfs -cat /user/hive/warehouse/encrypt_db4data.db/test_clusteredby/country=US/state=CA/california-employees.csv;

SHOW PARTITIONS encrypt_db4data.test_clusteredby;

ALTER TABLE encrypt_db4data.test_clusteredby TOUCH;
ALTER TABLE encrypt_db4data.test_clusteredby TOUCH PARTITION (country = 'US', state = 'CA');

ALTER TABLE encrypt_db4data.test_clusteredby CLUSTERED BY (name, encrypt_address) SORTED BY (encrypt_salary) INTO 48 BUCKETS;

DROP TABLE encrypt_db4data.test_clusteredby;



val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TBLPROPERTIES mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS IN mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS FROM mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);




