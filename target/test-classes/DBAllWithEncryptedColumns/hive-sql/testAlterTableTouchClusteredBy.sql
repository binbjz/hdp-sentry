--encrypt_db4data.encrypt_employees=encrypt_name,encrypt_salary,encrypt_subordinates,encrypt_deductions,encrypt_address
--CREATE DATABASE encrypt_db4data;
--DROP DATABASE encrypt_db4data;

USE encrypt_db4data;

CREATE TABLE encrypt_db4data.encrypt_employees (
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
INTO TABLE encrypt_db4data.encrypt_employees
PARTITION (country = 'US', state = 'CA');

dfs -cat /user/hive/warehouse/encrypt_db4data.db/encrypt_employees/country=US/state=CA/california-employees.csv;

SHOW PARTITIONS encrypt_db4data.encrypt_employees;

ALTER TABLE encrypt_db4data.encrypt_employees TOUCH;
ALTER TABLE encrypt_db4data.encrypt_employees TOUCH PARTITION (country = 'US', state = 'CA');

ALTER TABLE encrypt_db4data.encrypt_employees CLUSTERED BY (encrypt_name, encrypt_address) SORTED BY (encrypt_salary) INTO 48 BUCKETS;

DROP TABLE encrypt_db4data.encrypt_employees;
