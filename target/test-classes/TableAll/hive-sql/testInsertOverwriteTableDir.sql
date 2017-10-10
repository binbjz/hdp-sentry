--Execution:
ALTER TABLE testDB.staged_employees ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE testDB.staged_employees ADD PARTITION (country = 'US', state = 'OR');
ALTER TABLE testDB.staged_employees ADD PARTITION (country = 'US', state = 'IL');
ALTER TABLE testDB.employees ADD PARTITION (country = 'US', state = 'CA');

set FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
LOAD DATA LOCAL INPATH '''${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE testDB.staged_employees
PARTITION (country = 'US', state = 'CA');


FROM testDB.staged_employees se
INSERT OVERWRITE TABLE testDB.employees PARTITION (country = 'US', state = 'OR')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'OR'
INSERT OVERWRITE TABLE testDB.employees PARTITION (country = 'US', state = 'IL')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'IL'
INSERT OVERWRITE TABLE testDB.employees PARTITION (country = 'US', state = 'CA')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'CA';

SET hive.cli.print.header=true;
SELECT * FROM testDB.employees;
TRUNCATE TABLE testDB.employees;

INSERT OVERWRITE TABLE testDB.employees PARTITION (country = 'US', state = 'CA')
SELECT name, salary, subordinates, deductions, address FROM testDB.staged_employees se WHERE se.country = 'US' AND se.state = 'CA';
SELECT * FROM testDB.employees;
TRUNCATE TABLE testDB.employees;

SET hive.exec.dynamic.partition=true;
SET hive.vectorized.execution.enabled = true;
SET hive.vectorized.execution.reduce.enabled = true;
INSERT OVERWRITE TABLE testDB.employees PARTITION (country = 'US', state)
SELECT se.name, se.salary, se.subordinates, se.deductions, se.address, se.state FROM testDB.staged_employees se WHERE se.country = 'US';
SELECT * FROM testDB.employees;

INSERT OVERWRITE LOCAL DIRECTORY '/tmp/ca_employees'
SELECT * FROM testDB.staged_employees se WHERE se.country = 'US' and se.state = 'CA';
!ls -l /tmp/ca_employees;
!ls -rm -r /tmp/ca_employees;

FROM (
      SELECT emp.name, emp.salary FROM testDB.staged_employees emp WHERE emp.salary < 6000
      UNION ALL
      SELECT emp.name, emp.salary FROM testDB.staged_employees emp WHERE emp.salary > 7000
) unioninput
INSERT OVERWRITE DIRECTORY '/tmp/union.out' SELECT unioninput.*;
dfs -cat '/tmp/union.out/*';
dfs -rm -r /tmp/union.out;

ANALYZE TABLE testDB.staged_employees COMPUTE STATISTICS FOR columns name, salary;
-- 只搜集分区
ANALYZE TABLE testDB.staged_employees PARTITION (country = 'US', state = 'CA') COMPUTE STATISTICS;
-- 如果执行,则同时搜集分区间OR/CA/IL
ANALYZE TABLE testDB.staged_employees PARTITION (country = 'US', state)  COMPUTE STATISTICS;
-- 如果执行 搜集所有分区
ANALYZE TABLE testDB.staged_employees PARTITION (country, state) COMPUTE STATISTICS;
-- 查看分区的统计信息：
DESCRIBE EXTENDED testDB.staged_employees;
DESCRIBE EXTENDED testDB.staged_employees PARTITION (country = 'US', state = 'CA');

DROP TABLE testDB.staged_employees;
DROP TABLE testDB.employees;