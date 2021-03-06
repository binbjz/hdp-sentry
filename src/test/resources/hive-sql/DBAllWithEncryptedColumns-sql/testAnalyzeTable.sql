--encrypt_db4data.encrypt_test_analyze=encrypt_salary
--CREATE DATABASE encrypt_db4data;
--DROP DATABASE encrypt_db4data;

USE encrypt_db4data;
CREATE TABLE encrypt_db4data.encrypt_test_analyze (
 name STRING
,encrypt_salary FLOAT
,subordinates ARRAY<STRING>
,deductions MAP<STRING, FLOAT>
,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;

ALTER TABLE encrypt_db4data.encrypt_test_analyze ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE encrypt_db4data.encrypt_test_analyze ADD PARTITION (country = 'US', state = 'OR');
ALTER TABLE encrypt_db4data.encrypt_test_analyze ADD PARTITION (country = 'US', state = 'IL');

--SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/source-data;
--LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
LOAD DATA LOCAL INPATH '${env:FILEPATH}/california-employees.csv'
INTO TABLE encrypt_db4data.encrypt_test_analyze
PARTITION (country = 'US', state = 'CA');

SET hive.cli.print.header=true;

ANALYZE TABLE encrypt_db4data.encrypt_test_analyze COMPUTE STATISTICS FOR COLUMNS name, encrypt_salary;
-- 只搜集分区
ANALYZE TABLE encrypt_db4data.encrypt_test_analyze PARTITION (country = 'US', state = 'CA') COMPUTE STATISTICS;
-- 如果执行,则同时搜集分区间OR/CA/IL
ANALYZE TABLE encrypt_db4data.encrypt_test_analyze PARTITION (country = 'US', state)  COMPUTE STATISTICS;
-- 如果执行 搜集所有分区
ANALYZE TABLE encrypt_db4data.encrypt_test_analyze PARTITION (country, state) COMPUTE STATISTICS;
-- 查看分区的统计信息
DESCRIBE EXTENDED encrypt_db4data.encrypt_test_analyze;
DESCRIBE EXTENDED encrypt_db4data.encrypt_test_analyze PARTITION (country = 'US', state = 'CA');

dfs -rm /user/hive/warehouse/encrypt_db4data.db/encrypt_test_analyze/country=US/state=CA/california-employees.csv;

DROP TABLE encrypt_db4data.encrypt_test_analyze;
