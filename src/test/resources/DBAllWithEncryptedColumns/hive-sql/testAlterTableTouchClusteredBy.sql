--encrypt_db4data.test_clusteredby=encrypt_name,encrypt_salary,encrypt_subordinates,encrypt_deductions,encrypt_address
--CREATE DATABASE encrypt_db4data;
--DROP DATABASE encrypt_db4data;

USE encrypt_db4data;

CREATE TABLE encrypt_db4data.test_clusteredby (
 encrypt_name STRING
,encrypt_salary FLOAT
,encrypt_subordinates ARRAY<STRING>
,encrypt_deductions MAP<STRING, FLOAT>
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

ALTER TABLE encrypt_db4data.test_clusteredby CLUSTERED BY (encrypt_name, encrypt_address) SORTED BY (encrypt_salary) INTO 48 BUCKETS;

DROP TABLE encrypt_db4data.test_clusteredby;

--encrypt_db4alter.test_partition=encrypt_id,encrypt_part,encrypt_quantity
--encrypt_db4alter.test_enable_disable_partition=encrypt_hms,encrypt_severity,encrypt_server,encrypt_process_id,encrypt_message
--encrypt_db4alter.tbl4addcolumn=encrypt_col1,encrypt_col2,encrypt_col3
--encrypt_db4alter.tbl4change=encrypt_col1,encrypt_col2,encrypt_col3
--encrypt_db4alter.test_enable_disable=encrypt_hms,encrypt_severity,encrypt_server,encrypt_process_id,encrypt_message
--encrypt_db4alter.tbl4rename=encrypt_col1,encrypt_col2,encrypt_col3
--encrypt_db4alter.tbl4replace=encrypt_col1,encrypt_col2,encrypt_col3
--encrypt_db4alter.tbl4fileformat=encrypt_hms,encrypt_severity,encrypt_server,encrypt_process_id,encrypt_message
--encrypt_db4alter.tbl4fileformat_external=encrypt_hms,encrypt_severity,encrypt_server,encrypt_process_id,encrypt_message
--encrypt_db4data.test_clusteredby=encrypt_name,encrypt_salary,encrypt_subordinates,encrypt_deductions,encrypt_address

--encrypt_db4data.test_serde_partition=encrypt_c0,encrypt_c1,encrypt_c2
--encrypt_db4data.test_serde=encrypt_c0,encrypt_c1,encrypt_c2

--CREATE DATABASE encrypt_db4alter;
--DROP DATABASE encrypt_db4alter;
--CREATE DATABASE encrypt_db4data;
--DROP DATABASE encrypt_db4data;
--encrypt_db4data.encrypt_test_analyze=encrypt_name,encrypt_salary,encrypt_subordinates,encrypt_deductions,encrypt_address
--CREATE DATABASE encrypt_db4data;
--DROP DATABASE encrypt_db4data;
--encrypt_db4data.tbl4builtinfuncs=col1,col2,col3
--CREATE DATABASE encrypt_db4data;
--DROP DATABASE encrypt_db4data;

--encrypt_db4tbl.tbl4view=encrypt_c0,encrypt_c1,encrypt_c2
--CREATE DATABASE encrypt_db4alter;
--DROP DATABASE encrypt_db4alter;

