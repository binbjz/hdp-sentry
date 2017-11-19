//encrypt_db4data.encrypt_import_export=encrypt_name,encrypt_salary
//encrypt_db4data.encrypt_tgt_import_export=encrypt_name,encrypt_salary
//CREATE DATABASE encrypt_db4data;
//DROP DATABASE encrypt_db4data;

USE encrypt_db4data2;

CREATE TABLE encrypt_db4data2.encrypt_import_export (
 encrypt_name STRING
,encrypt_salary FLOAT
,subordinates ARRAY<STRING>
,deductions MAP<STRING, FLOAT>
,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;

CREATE TABLE encrypt_db4data2.encrypt_tgt_import_export (
 encrypt_name STRING
,encrypt_salary FLOAT
,subordinates ARRAY<STRING>
,deductions MAP<STRING, FLOAT>
,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/source-data;

LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE encrypt_db4data2.encrypt_import_export
PARTITION (country = 'US', state = 'CA');

dfs -cat /user/hive/warehouse/encrypt_db4data2.db/encrypt_import_export/country=US/state=CA/california-employees.csv;
dfs -count /user/hive/warehouse/encrypt_db4data2.db/encrypt_import_export/country=US/state=CA/california-employees.csv;

dfs -copyToLocal /user/hive/warehouse/encrypt_db4data2.db/encrypt_import_export/country=US/state=CA/california-employees.csv /tmp/california-employees.csv;
!ls -l /tmp/california-employees.csv;
!rm -r /tmp/california-employees.csv;

-- 导出分区并且导入到分区表分区
EXPORT TABLE encrypt_db4data2.encrypt_import_export PARTITION (country = 'US', state = 'CA') TO '/tmp/employee';
dfs -cat /tmp/employee/country=US/state=CA/california-employees.csv;

IMPORT TABLE encrypt_db4data2.encrypt_tgt_import_export PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee';
SHOW PARTITIONS encrypt_db4data2.encrypt_tgt_import_export;

dfs -rm -r /tmp/employee;

DROP TABLE encrypt_db4data2.encrypt_import_export;
DROP TABLE encrypt_db4data2.encrypt_tgt_import_export;


val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TBLPROPERTIES mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS IN mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS FROM mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
