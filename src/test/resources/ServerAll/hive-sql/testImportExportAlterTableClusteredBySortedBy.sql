DROP DATABASE IF EXISTS db4alter CASCADE;
CREATE DATABASE db4alter;

CREATE TABLE db4alter.employees (
  name STRING
 ,salary FLOAT
 ,subordinates ARRAY<STRING>
 ,deductions MAP<STRING, FLOAT>
 ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;

CREATE TABLE db4alter.src_tgt_employees (
  name STRING
 ,salary FLOAT
 ,subordinates ARRAY<STRING>
 ,deductions MAP<STRING, FLOAT>
 ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;

USE db4alter;

ALTER TABLE db4alter.src_tgt_employees ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE db4alter.employees ADD PARTITION (country = 'US', state = 'CA');

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data/;
SELECT '${hiveconf:FILEPATH}';

LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE db4alter.src_tgt_employees
PARTITION (country = 'US', state = 'CA');

EXPORT TABLE db4alter.src_tgt_employees PARTITION (country = 'US', state = 'CA') TO '/tmp/employee';
dfs -cat /tmp/employee/country=US/state=CA/california-employees.csv;

IMPORT TABLE db4alter.employees PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee';
SHOW PARTITIONS db4alter.employees;

ALTER TABLE db4alter.employees TOUCH;

ALTER TABLE db4alter.src_tgt_employees TOUCH PARTITION (country = 'US', state = 'CA') ;
ALTER TABLE db4alter.employees TOUCH PARTITION (country = 'US', state = 'CA') ;
ALTER TABLE db4alter.employees ADD PARTITION (country = 'CHN', state = 'BJ') ;
ALTER TABLE db4alter.employees TOUCH PARTITION (country = 'CHN', state = 'BJ') ;

DESCRIBE db4alter.employees PARTITION (country='US', state='CA');
DESCRIBE EXTENDED db4alter.employees PARTITION (country='US', state='CA');

ALTER TABLE db4alter.employees CLUSTERED BY (name, address) SORTED BY (salary) INTO 48 BUCKETS;
dfs -rm -r /tmp/employee;

DROP TABLE db4alter.employees;
DROP TABLE db4alter.src_tgt_employees;

DROP DATABASE db4alter CASCADE;
