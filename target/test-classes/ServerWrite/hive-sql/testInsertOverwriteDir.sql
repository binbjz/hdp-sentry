--DROP DATABASE IF EXISTS db4data CASCADE;
--CREATE DATABASE db4data;
--CREATE TABLE db4data.src_employees_dir (
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

--DROP TABLE db4data.src_employees_dir;
--DROP DATABASE db4data;

USE db4data;

ALTER TABLE db4data.src_employees_dir ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE db4data.src_employees_dir ADD PARTITION (country = 'US', state = 'OR');
ALTER TABLE db4data.src_employees_dir ADD PARTITION (country = 'US', state = 'IL');

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE db4data.src_employees_dir
PARTITION (country = 'US', state = 'CA');

SELECT * FROM db4data.src_employees_dir;

SET hive.exec.dynamic.partition=true;
SET hive.vectorized.execution.enabled = true;
SET hive.vectorized.execution.reduce.enabled = true;

INSERT OVERWRITE LOCAL DIRECTORY '/tmp/ca_employees'
SELECT * FROM db4data.src_employees_dir se WHERE se.country = 'US' and se.state = 'CA';
!ls -l /tmp/ca_employees;
!rm -r /tmp/ca_employees;

FROM (
      SELECT emp.name, emp.salary FROM db4data.src_employees_dir emp WHERE emp.salary < 6000
      UNION ALL
      SELECT emp.name, emp.salary FROM db4data.src_employees_dir emp WHERE emp.salary > 7000
) unioninput
INSERT OVERWRITE DIRECTORY '/tmp/union.out' SELECT unioninput.*;
dfs -cat /tmp/union.out/* ;
dfs -rm -r /tmp/union.out ;
