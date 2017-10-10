--Execution:
ALTER TABLE test_db.staged_employees ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE test_db.employees ADD PARTITION (country = 'US', state = 'CA');

set FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
SELECT '${hiveconf:FILEPATH}';

LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE test_db.staged_employees
PARTITION (country = 'US', state = 'CA');

-- TRUNCATE TABLE test_db.staged_employees;
-- export FILEPATH=/opt/meituan/qa_test/testfile;
-- echo $FILEPATH;
-- LOAD DATA LOCAL INPATH '${env:FILEPATH}/california-employees.csv'
-- INTO TABLE test_db.staged_employees
-- PARTITION (country = 'US', state = 'CA');

-- 导出分区并且导入到分区表分区
EXPORT TABLE test_db.staged_employees PARTITION (country = 'US', state = 'CA') TO '/tmp/employee';
dfs -cat /tmp/employee/country=US/state=CA/california-employees.csv;

IMPORT TABLE test_db.employees PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee';
SHOW PARTITIONS test_db.employees;

ALTER TABLE test_db.employees TOUCH;
ALTER TABLE test_db.staged_employees TOUCH PARTITION (country = 'US', state = 'CA');
ALTER TABLE test_db.employees TOUCH PARTITION (country = 'US', state = 'CA');
ALTER TABLE test_db.employees ADD PARTITION (country = 'CHN', state = 'BJ');
ALTER TABLE test_db.employees TOUCH PARTITION (country = 'CHN', state = 'BJ');

DESCRIBE test_db.employees PARTITION (country='US', state='CA');
DESCRIBE EXTENDED test_db.employees PARTITION (country='US', state='CA');

ALTER TABLE test_db.employees CLUSTERED BY (name, address) SORTED BY (salary) INTO 48 BUCKETS;
dfs -rm -R /tmp/employee;
