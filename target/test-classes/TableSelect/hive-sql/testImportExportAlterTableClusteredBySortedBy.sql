USE testdb;

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;

LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE testdb.src_tgt_employees02
PARTITION (country = 'US', state = 'CA');

EXPORT TABLE testdb.src_tgt_employees02 PARTITION (country = 'US', state = 'CA') TO '/tmp/employee';
dfs -cat /tmp/employee/country=US/state=CA/california-employees.csv;

IMPORT TABLE testdb.employees022 PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee';
SHOW PARTITIONS testdb.employees022;

ALTER TABLE testdb.employees02 TOUCH;

ALTER TABLE testdb.src_tgt_employees02 TOUCH PARTITION (country = 'US', state = 'CA') ;
ALTER TABLE testdb.employees02 TOUCH PARTITION (country = 'US', state = 'CA') ;

ALTER TABLE testdb.employees02 TOUCH PARTITION (country = 'CHN', state = 'BJ') ;

DESCRIBE testdb.employees02 PARTITION (country='US', state='CA');
DESCRIBE EXTENDED testdb.employees02 PARTITION (country='US', state='CA');

ALTER TABLE testdb.employees02 CLUSTERED BY (name, address) SORTED BY (salary) INTO 48 BUCKETS;
dfs -rm -r /tmp/employee;

DROP TABLE testdb.employees02;
DROP TABLE testdb.src_tgt_employees02;
DROP TABLE testdb.src_tgt_employees022;
