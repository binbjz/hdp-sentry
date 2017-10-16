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

CREATE TABLE encrypt_db4data.employees (
 name STRING
,salary FLOAT
,subordinates ARRAY<STRING>
,deductions MAP<STRING, FLOAT>
,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;

ALTER TABLE encrypt_db4data.staged_employees ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE encrypt_db4data.staged_employees ADD PARTITION (country = 'US', state = 'OR');
ALTER TABLE encrypt_db4data.staged_employees ADD PARTITION (country = 'US', state = 'IL');

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE encrypt_db4data.staged_employees
PARTITION (country = 'US', state = 'CA');


FROM encrypt_db4data.staged_employees se
INSERT OVERWRITE TABLE encrypt_db4data.employees PARTITION (country = 'US', state = 'OR')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'OR'
INSERT OVERWRITE TABLE encrypt_db4data.employees PARTITION (country = 'US', state = 'IL')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'IL'
INSERT OVERWRITE TABLE encrypt_db4data.employees PARTITION (country = 'US', state = 'CA')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'CA';

SET hive.cli.print.header=true;
SELECT * FROM encrypt_db4data.employees;

INSERT OVERWRITE TABLE encrypt_db4data.employees PARTITION (country = 'US', state = 'CA')
SELECT name, salary, subordinates, deductions, address FROM encrypt_db4data.staged_employees se WHERE se.country = 'US' AND se.state = 'CA';

TRUNCATE TABLE encrypt_db4data.employees;

SET hive.exec.dynamic.partition=true;
SET hive.vectorized.execution.enabled = true;
SET hive.vectorized.execution.reduce.enabled = true;
INSERT OVERWRITE TABLE encrypt_db4data.employees PARTITION (country = 'US', state)
SELECT se.name, se.salary, se.subordinates, se.deductions, se.address, se.state FROM encrypt_db4data.staged_employees se WHERE se.country = 'US';
SELECT * FROM encrypt_db4data.employees;

INSERT OVERWRITE LOCAL DIRECTORY '/tmp/ca_employees'
SELECT * FROM encrypt_db4data.staged_employees se WHERE se.country = 'US' and se.state = 'CA';
!ls -l /tmp/ca_employees;
!ls -rm -r /tmp/ca_employees;

FROM (
SELECT emp.name, emp.salary FROM encrypt_db4data.staged_employees emp WHERE emp.salary < 6000
UNION ALL
SELECT emp.name, emp.salary FROM encrypt_db4data.staged_employees emp WHERE emp.salary > 7000
) unioninput
INSERT OVERWRITE DIRECTORY '/tmp/union.out' SELECT unioninput.*;

dfs -cat /tmp/union.out/* ;
dfs -rm -r /tmp/union.out ;

ANALYZE TABLE encrypt_db4data.staged_employees COMPUTE STATISTICS FOR columns name, salary;
-- 只搜集分区
ANALYZE TABLE encrypt_db4data.staged_employees PARTITION (country = 'US', state = 'CA') COMPUTE STATISTICS;
-- 如果执行,则同时搜集分区间OR/CA/IL
ANALYZE TABLE encrypt_db4data.staged_employees PARTITION (country = 'US', state)  COMPUTE STATISTICS;
-- 如果执行 搜集所有分区
ANALYZE TABLE encrypt_db4data.staged_employees PARTITION (country, state) COMPUTE STATISTICS;
-- 查看分区的统计信息
DESCRIBE EXTENDED encrypt_db4data.staged_employees;
DESCRIBE EXTENDED encrypt_db4data.staged_employees PARTITION (country = 'US', state = 'CA');

dfs -rm /user/warehouse/hive/encrypt_db4data.db/staged_employees/california-employees.csv

DROP TABLE encrypt_db4data.staged_employees;
DROP TABLE encrypt_db4data.employees;
