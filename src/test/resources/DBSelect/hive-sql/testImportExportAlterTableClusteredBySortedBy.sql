USE testdb;
ALTER TABLE testdb.staged_employees02 ADD PARTITION (country = 'US', state = 'CA');


SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
SELECT '${hiveconf:FILEPATH}' AS filepath;

LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE testdb.staged_employees02
PARTITION (country = 'US', state = 'CA');

-- 导出分区并且导入到分区表分区
EXPORT TABLE testdb.staged_employees02 PARTITION (country = 'US', state = 'CA') TO '/tmp/employee';
dfs -cat /tmp/employee/country=US/state=CA/california-employees.csv;

IMPORT TABLE testdb.employees02 PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee';
SHOW PARTITIONS testdb.employees02;

ALTER TABLE testdb.employees02 TOUCH;

ALTER TABLE testdb.staged_employees02 TOUCH PARTITION (country = 'US', state = 'CA') ;
ALTER TABLE testdb.employees02 TOUCH PARTITION (country = 'US', state = 'CA') ;

DESCRIBE testdb.employees02 PARTITION (country='US', state='CA');
DESCRIBE EXTENDED testdb.employees02 PARTITION (country='US', state='CA');

ALTER TABLE testdb.employees02 CLUSTERED BY (name, address) SORTED BY (salary) INTO 48 BUCKETS;
dfs -rm -r /tmp/employee;
