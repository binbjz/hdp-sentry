CREATE TABLE jinxin.employees (
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


CREATE TABLE jinxin.staged_employees2 (
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

CREATE TABLE jinxin.staged_employees (
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

USE jinxin;

ALTER TABLE jinxin.staged_employees ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE jinxin.employees ADD PARTITION (country = 'US', state = 'CA');

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data/;
SELECT '${hiveconf:FILEPATH}';

LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE jinxin.staged_employees
PARTITION (country = 'US', state = 'CA');

EXPORT TABLE jinxin.staged_employees PARTITION (country = 'US', state = 'CA') TO '/tmp/employee';
dfs -cat /tmp/employee/country=US/state=CA/california-employees.csv;

IMPORT TABLE jinxin.staged_employees2 PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee';


IMPORT TABLE jinxin.employees PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee';
SHOW PARTITIONS jinxin.employees;

ALTER TABLE jinxin.employees TOUCH;

ALTER TABLE jinxin.staged_employees TOUCH PARTITION (country = 'US', state = 'CA') ;
ALTER TABLE jinxin.employees TOUCH PARTITION (country = 'US', state = 'CA') ;
ALTER TABLE jinxin.employees ADD PARTITION (country = 'CHN', state = 'BJ') ;
ALTER TABLE jinxin.employees TOUCH PARTITION (country = 'CHN', state = 'BJ') ;

DESCRIBE jinxin.employees PARTITION (country='US', state='CA');
DESCRIBE EXTENDED jinxin.employees PARTITION (country='US', state='CA');

ALTER TABLE jinxin.employees CLUSTERED BY (name, address) SORTED BY (salary) INTO 48 BUCKETS;
dfs -rm -r /tmp/employee;

DROP TABLE jinxin.employees;
DROP TABLE jinxin.staged_employees;

DROP DATABASE jinxin CASCADE;










CREATE TABLE jinxin.employees (
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

CREATE TABLE jinxin.staged_employees (
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

ALTER TABLE jinxin.staged_employees ADD PARTITION (country = 'US', state = 'CA');

SET FILEPATH=/opt/meituan/qa_test/testfile;
SELECT '${hiveconf:FILEPATH}' AS filepath;

LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE jinxin.staged_employees
PARTITION (country = 'US', state = 'CA');

dfs -cat /user/hive/warehouse/jinxin.db/staged_employees/country=US/state=CA/california-employees.csv;

-- 导出分区并且导入到分区表分区
EXPORT TABLE jinxin.staged_employees PARTITION (country = 'US', state = 'CA') TO '/tmp/employee';
dfs -cat /tmp/employee/country=US/state=CA/california-employees.csv;

IMPORT TABLE jinxin.employees PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee';
SHOW PARTITIONS jinxin.employees;



CREATE TABLE encrypt_db4data.employees (
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

CREATE TABLE encrypt_db4data.staged_employees (
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

ALTER TABLE encrypt_db4data.staged_employees ADD PARTITION (country = 'US', state = 'CA');

SET FILEPATH=/opt/meituan/qa_test/testfile;
SELECT '${hiveconf:FILEPATH}' AS filepath;

LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE encrypt_db4data.staged_employees
PARTITION (country = 'US', state = 'CA');

dfs -cat /user/hive/warehouse/encrypt_db4data.db/staged_employees/country=US/state=CA/california-employees.csv;

-- 导出分区并且导入到分区表分区
EXPORT TABLE encrypt_db4data.staged_employees PARTITION (country = 'US', state = 'CA') TO '/tmp/employee';
dfs -cat /tmp/employee/country=US/state=CA/california-employees.csv;

IMPORT TABLE encrypt_db4data.employees PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee';
SHOW PARTITIONS encrypt_db4data.employees;

ALTER TABLE encrypt_db4data.employees TOUCH;

ALTER TABLE encrypt_db4data.staged_employees TOUCH PARTITION (country = 'US', state = 'CA') ;
ALTER TABLE encrypt_db4data.employees TOUCH PARTITION (country = 'US', state = 'CA') ;

DESCRIBE encrypt_db4data.employees PARTITION (country='US', state='CA');
DESCRIBE EXTENDED encrypt_db4data.employees PARTITION (country='US', state='CA');

ALTER TABLE encrypt_db4data.employees CLUSTERED BY (name, address) SORTED BY (salary) INTO 48 BUCKETS;
dfs -rm -r /tmp/employee;

dfs -rm /user/hive/warehouse/encrypt_db4data.db/staged_employees/country=US/state=CA/california-employees.csv;
DROP TABLE encrypt_db4data.employees;
DROP TABLE encrypt_db4data.staged_employees;
