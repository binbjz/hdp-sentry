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
TRUNCATE TABLE testdb.employees;

INSERT OVERWRITE TABLE testdb.employees PARTITION (country = 'US', state = 'CA')
SELECT name, salary, subordinates, deductions, address FROM testdb.src_employees se WHERE se.country = 'US' AND se.state = 'CA';
SELECT * FROM testdb.employees;
TRUNCATE TABLE testdb.employees;

SET hive.exec.dynamic.partition=true;
SET hive.vectorized.execution.enabled = true;
SET hive.vectorized.execution.reduce.enabled = true;
INSERT OVERWRITE TABLE testdb.employees PARTITION (country = 'US', state)
SELECT se.name, se.salary, se.subordinates, se.deductions, se.address, se.state FROM testdb.src_employees se WHERE se.country = 'US';
SELECT * FROM testdb.employees;
