USE testdb;
SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE testdb.src_employees
PARTITION (country = 'US', state = 'CA');

FROM testdb.src_employees se
INSERT OVERWRITE TABLE testdb.employees PARTITION (country = 'US', state = 'OR')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'OR'
INSERT OVERWRITE TABLE testdb.employees PARTITION (country = 'US', state = 'IL')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'IL'
INSERT OVERWRITE TABLE testdb.employees PARTITION (country = 'US', state = 'CA')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'CA';

SET hive.cli.print.header=true;
SELECT * FROM testdb.employees;

INSERT OVERWRITE TABLE testdb.employees PARTITION (country = 'US', state = 'CA')
SELECT name, salary, subordinates, deductions, address FROM testdb.src_employees se WHERE se.country = 'US' AND se.state = 'CA';

TRUNCATE TABLE testdb.employees;

SET hive.exec.dynamic.partition=true;
SET hive.vectorized.execution.enabled = true;
SET hive.vectorized.execution.reduce.enabled = true;
INSERT OVERWRITE TABLE testdb.employees PARTITION (country = 'US', state)
SELECT se.name, se.salary, se.subordinates, se.deductions, se.address, se.state FROM testdb.src_employees se WHERE se.country = 'US';
SELECT * FROM testdb.employees;

INSERT OVERWRITE LOCAL DIRECTORY '/tmp/ca_employees'
SELECT * FROM testdb.src_employees se WHERE se.country = 'US' and se.state = 'CA';
!ls -l /tmp/ca_employees;
!rm -r /tmp/ca_employees;

FROM (
SELECT emp.name, emp.salary FROM testdb.src_employees emp WHERE emp.salary < 6000
UNION ALL
SELECT emp.name, emp.salary FROM testdb.src_employees emp WHERE emp.salary > 7000
) unioninput
INSERT OVERWRITE DIRECTORY '/tmp/union.out' SELECT unioninput.*;
dfs -cat /tmp/union.out/* ;
dfs -rm -r /tmp/union.out ;

ANALYZE TABLE testdb.src_employees COMPUTE STATISTICS FOR columns name, salary;
-- 只搜集分区
ANALYZE TABLE testdb.src_employees PARTITION (country = 'US', state = 'CA') COMPUTE STATISTICS;
-- 如果执行,则同时搜集分区间OR/CA/IL
ANALYZE TABLE testdb.src_employees PARTITION (country = 'US', state)  COMPUTE STATISTICS;
-- 如果执行 搜集所有分区
ANALYZE TABLE testdb.src_employees PARTITION (country, state) COMPUTE STATISTICS;
ANALYZE TABLE testdb.src_employees COMPUTE STATISTICS;
-- 查看分区的统计信息：
DESCRIBE EXTENDED testdb.src_employees;
DESCRIBE EXTENDED testdb.src_employees PARTITION (country = 'US', state = 'CA');
