USE testdb;

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;

LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE testdb.src_import_export
PARTITION (country = 'US', state = 'CA');

EXPORT TABLE testdb.src_import_export PARTITION (country = 'US', state = 'CA') TO '/tmp/employee';
dfs -cat /tmp/employee/country=US/state=CA/california-employees.csv;

ALTER TABLE testdb.import_export DROP PARTITION (country = 'US', state = 'CA');
IMPORT TABLE testdb.import_export PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee';
SHOW PARTITIONS testdb.import_export;

ALTER TABLE testdb.import_export TOUCH;

ALTER TABLE testdb.src_import_export TOUCH PARTITION (country = 'US', state = 'CA') ;
ALTER TABLE testdb.import_export TOUCH PARTITION (country = 'US', state = 'CA') ;

DESCRIBE testdb.import_export PARTITION (country='US', state='CA');
DESCRIBE EXTENDED testdb.import_export PARTITION (country='US', state='CA');

ALTER TABLE testdb.import_export CLUSTERED BY (name, address) SORTED BY (salary) INTO 48 BUCKETS;
dfs -rm -r /tmp/employee;
