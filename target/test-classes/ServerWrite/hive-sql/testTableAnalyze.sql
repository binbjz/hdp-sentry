--DROP DATABASE IF EXISTS db4data CASCADE;
--CREATE DATABASE db4data;
--CREATE TABLE db4data.src_employees_analyze (
--   name STRING
--  ,salary FLOAT
--  ,subordinates ARRAY<STRING>
--  ,deductions MAP<STRING, FLOAT>
--  ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
--) PARTITIONED BY (country STRING, state STRING)
--ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
--COLLECTION ITEMS TERMINATED BY '|'
--MAP KEYS TERMINATED BY '='
--LINES TERMINATED BY '\n' STORED AS TEXTFILE;

--DROP TABLE db4data.src_employees_analyze;
--DROP DATABASE db4data;

USE db4data;

ALTER TABLE db4data.src_employees_analyze ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE db4data.src_employees_analyze ADD PARTITION (country = 'US', state = 'OR');
ALTER TABLE db4data.src_employees_analyze ADD PARTITION (country = 'US', state = 'IL');

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE db4data.src_employees_analyze
PARTITION (country = 'US', state = 'CA');

SELECT * FROM db4data.src_employees_analyze;

ANALYZE TABLE db4data.src_employees_analyze COMPUTE STATISTICS FOR columns name, salary;
ANALYZE TABLE db4data.src_employees_analyze PARTITION (country = 'US', state = 'CA') COMPUTE STATISTICS;
ANALYZE TABLE db4data.src_employees_analyze PARTITION (country = 'US', state)  COMPUTE STATISTICS;
ANALYZE TABLE db4data.src_employees_analyze PARTITION (country, state) COMPUTE STATISTICS;

DESCRIBE EXTENDED db4data.src_employees_analyze;
DESCRIBE EXTENDED db4data.src_employees_analyze PARTITION (country = 'US', state = 'CA');
