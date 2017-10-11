USE testdb;
ALTER TABLE testdb.staged_employees ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE testdb.employees ADD PARTITION (country = 'US', state = 'CA');

set FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
SELECT '${hiveconf:FILEPATH}';

LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE testdb.staged_employees
PARTITION (country = 'US', state = 'CA');

EXPORT TABLE testdb.staged_employees PARTITION (country = 'US', state = 'CA') TO '/tmp/employee';
dfs -cat /tmp/employee/country=US/state=CA/california-employees.csv;

ALTER TABLE testdb.employees DROP PARTITION (country = 'US', state = 'CA');
IMPORT TABLE testdb.employees PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee';
SHOW PARTITIONS testdb.employees;

ALTER TABLE testdb.employees TOUCH;

ALTER TABLE testdb.staged_employees TOUCH PARTITION (country = 'US', state = 'CA') ;
ALTER TABLE testdb.employees TOUCH PARTITION (country = 'US', state = 'CA') ;
ALTER TABLE testdb.employees ADD PARTITION (country = 'CHN', state = 'BJ') ;
ALTER TABLE testdb.employees TOUCH PARTITION (country = 'CHN', state = 'BJ') ;

DESCRIBE testdb.employees PARTITION (country='US', state='CA');
DESCRIBE EXTENDED testdb.employees PARTITION (country='US', state='CA');

ALTER TABLE testdb.employees CLUSTERED BY (name, address) SORTED BY (salary) INTO 48 BUCKETS;
dfs -rm -r /tmp/employee;

DROP TABLE testdb.employees;
DROP TABLE testdb.staged_employees;
