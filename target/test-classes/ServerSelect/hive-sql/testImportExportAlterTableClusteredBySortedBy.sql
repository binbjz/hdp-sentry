USE testdb;

--ALTER TABLE testdb.employees ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE testdb.src_employees ADD PARTITION (country = 'US', state = 'CA');

SET FILEPATH=/opt/meituan/qa_test/testfile;
SELECT '${hiveconf:FILEPATH}';
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE testdb.src_employees
PARTITION (country = 'US', state = 'CA');

EXPORT TABLE testdb.src_employees PARTITIONS (country = 'US', state = 'CA') TO '/tmp/employee';
IMPORT TABLE testdb.employees PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee';

ALTER TABLE testdb.employees TOUCH;

ALTER TABLE testdb.src_employees TOUCH PARTITION (country = 'US', state = 'CA') ;
ALTER TABLE testdb.employees TOUCH PARTITION (country = 'US', state = 'CA');

DESCRIBE testdb.employees PARTITION (country='US', state='CA');
DESCRIBE EXTENDED testdb.employees PARTITION (country='US', state='CA');

ALTER TABLE testdb.employees CLUSTERED BY (name, address) SORTED BY (salary) INTO 48 BUCKETS;
