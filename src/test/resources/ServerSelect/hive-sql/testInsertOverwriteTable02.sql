SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;

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

INSERT OVERWRITE TABLE test_db.employees PARTITION (country = 'US', state = 'CA')
SELECT name, salary, subordinates, deductions, address FROM test_db.staged_employees se WHERE se.country = 'US' AND se.state = 'CA';
