USE testDB;
ALTER TABLE testDB.staged_employees ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE testDB.employees ADD PARTITION (country = 'US', state = 'CA');

set FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
SELECT '${hiveconf:FILEPATH}';

LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE testDB.staged_employees
PARTITION (country = 'US', state = 'CA');

EXPORT TABLE testDB.staged_employees PARTITION (country = 'US', state = 'CA') TO '/tmp/employee';
dfs -cat /tmp/employee/country=US/state=CA/california-employees.csv;

ALTER TABLE testDB.employees DROP PARTITION (country = 'US', state = 'CA');
IMPORT TABLE testDB.employees PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee';
SHOW PARTITIONS testDB.employees;

ALTER TABLE testDB.employees TOUCH;

ALTER TABLE testDB.staged_employees TOUCH PARTITION (country = 'US', state = 'CA') ;
ALTER TABLE testDB.employees TOUCH PARTITION (country = 'US', state = 'CA') ;
ALTER TABLE testDB.employees ADD PARTITION (country = 'CHN', state = 'BJ') ;
ALTER TABLE testDB.employees TOUCH PARTITION (country = 'CHN', state = 'BJ') ;

DESCRIBE testDB.employees PARTITION (country='US', state='CA');
DESCRIBE EXTENDED testDB.employees PARTITION (country='US', state='CA');

ALTER TABLE testDB.employees CLUSTERED BY (name, address) SORTED BY (salary) INTO 48 BUCKETS;
dfs -rm -r /tmp/employee;

DROP TABLE testDB.employees;
DROP TABLE testDB.staged_employees;
