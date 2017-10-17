USE testdb;
ALTER TABLE testdb.src_tgt_employees ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE testdb.employees ADD PARTITION (country = 'US', state = 'CA');

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
SELECT '${hiveconf:FILEPATH}';

LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE testdb.src_tgt_employees
PARTITION (country = 'US', state = 'CA');

-- TRUNCATE TABLE testdb.src_tgt_employees;
-- export FILEPATH=/opt/meituan/qa_test/testfile;
-- echo $FILEPATH;
-- LOAD DATA LOCAL INPATH '${env:FILEPATH}/california-employees.csv'
-- INTO TABLE testdb.src_tgt_employees
-- PARTITION (country = 'US', state = 'CA');

-- 导出分区并且导入到分区表分区
EXPORT TABLE testdb.src_tgt_employees PARTITION (country = 'US', state = 'CA') TO '/tmp/employee';
dfs -cat /tmp/employee/country=US/state=CA/california-employees.csv;

IMPORT TABLE testdb.employees PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee';
SHOW PARTITIONS testdb.employees;

ALTER TABLE testdb.employees TOUCH;
ALTER TABLE testdb.src_tgt_employees TOUCH PARTITION (country = 'US', state = 'CA');
ALTER TABLE testdb.employees TOUCH PARTITION (country = 'US', state = 'CA');
ALTER TABLE testdb.employees ADD PARTITION (country = 'CHN', state = 'BJ');
ALTER TABLE testdb.employees TOUCH PARTITION (country = 'CHN', state = 'BJ');

DESCRIBE testdb.employees PARTITION (country='US', state='CA');
DESCRIBE EXTENDED testdb.employees PARTITION (country='US', state='CA');

ALTER TABLE testdb.employees CLUSTERED BY (name, address) SORTED BY (salary) INTO 48 BUCKETS;
dfs -rm -r /tmp/employee;
