CREATE TABLE test_db.staged_employees (
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

CREATE TABLE test_db.employees (
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

ALTER TABLE test_db.staged_employees ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE test_db.staged_employees ADD PARTITION (country = 'US', state = 'OR');
ALTER TABLE test_db.staged_employees ADD PARTITION (country = 'US', state = 'IL');

export FILEPATH=/opt/meituan/qa_test/testfile
echo $FILEPATH
LOAD DATA LOCAL INPATH '${env:FILEPATH}/california-employees.csv'
INTO TABLE test_db.staged_employees
PARTITION (country = 'US', state = 'CA');

FROM test_db.staged_employees se
INSERT OVERWRITE TABLE test_db.employees PARTITION (country = 'US', state = 'OR')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'OR'
INSERT OVERWRITE TABLE test_db.employees PARTITION (country = 'US', state = 'IL')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'IL'
INSERT OVERWRITE TABLE test_db.employees PARTITION (country = 'US', state = 'CA')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'CA';

SET hive.cli.print.header=true;
SELECT * FROM test_db.employees;

INSERT OVERWRITE TABLE test_db.employees PARTITION (country = 'US', state = 'CA')
SELECT name, salary, subordinates, deductions, address FROM test_db.staged_employees se WHERE se.country = 'US' AND se.state = 'CA';

TRUNCATE TABLE test_db.employees;

SET hive.exec.dynamic.partition=true;
SET hive.vectorized.execution.enabled = true;
SET hive.vectorized.execution.reduce.enabled = true;
INSERT OVERWRITE TABLE test_db.employees PARTITION (country = 'US', state)
SELECT se.name, se.salary, se.subordinates, se.deductions, se.address, se.state FROM test_db.staged_employees se WHERE se.country = 'US';
SELECT * FROM test_db.employees;

INSERT OVERWRITE LOCAL DIRECTORY '/tmp/ca_employees'
SELECT * FROM test_db.staged_employees se WHERE se.country = 'US' and se.state = 'CA';
!ls -l /tmp/ca_employees;

FROM (
SELECT emp.name, emp.salary FROM test_db.staged_employees emp WHERE emp.salary < 6000
UNION ALL
SELECT emp.name, emp.salary FROM test_db.staged_employees emp WHERE emp.salary > 7000
) unioninput
INSERT OVERWRITE DIRECTORY '/tmp/union.out' SELECT unioninput.*;
dfs -cat /tmp/union.out/* ;
dfs -rm -r /tmp/union.out ;

ANALYZE TABLE test_db.staged_employees COMPUTE STATISTICS FOR columns name, salary;
-- 只搜集分区
ANALYZE TABLE test_db.staged_employees PARTITION (country = 'US', state = 'CA') COMPUTE STATISTICS;
-- 如果执行,则同时搜集分区间OR/CA/IL
ANALYZE TABLE test_db.staged_employees PARTITION (country = 'US', state)  COMPUTE STATISTICS;
-- 如果执行 搜集所有分区
ANALYZE TABLE test_db.staged_employees PARTITION (country, state) COMPUTE STATISTICS;
ANALYZE TABLE test_db.staged_employees COMPUTE STATISTICS;
-- 查看分区的统计信息：
DESCRIBE EXTENDED test_db.staged_employees;
DESCRIBE EXTENDED test_db.staged_employees PARTITION (country = 'US', state = 'CA');

DROP TABLE test_db.staged_employees;
DROP TABLE test_db.employees;
