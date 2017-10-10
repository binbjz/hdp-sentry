SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;

LOAD DATA LOCAL INPATH '${env:FILEPATH}/california-employees.csv'
INTO TABLE testDB.staged_employees
PARTITION (country = 'US', state = 'CA');

FROM testDB.staged_employees se
INSERT OVERWRITE TABLE testDB.employees PARTITION (country = 'US', state = 'OR')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'OR'
INSERT OVERWRITE TABLE testDB.employees PARTITION (country = 'US', state = 'IL')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'IL'
INSERT OVERWRITE TABLE testDB.employees PARTITION (country = 'US', state = 'CA')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'CA';

INSERT OVERWRITE TABLE testDB.employees PARTITION (country = 'US', state = 'CA')
SELECT name, salary, subordinates, deductions, address FROM testDB.staged_employees se WHERE se.country = 'US' AND se.state = 'CA';
