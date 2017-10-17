ALTER TABLE testdb.employees02 ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE testdb.src_employees02 ADD PARTITION (country = 'US', state = 'CA');

SET FILEPATH=/opt/meituan/qa_test/testfile;
SELECT '${hiveconf:FILEPATH}';
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE testdb.src_employees02
PARTITION (country = 'US', state = 'CA');

-- 导出分区并且导入到分区表分区
EXPORT TABLE testdb.src_employees02 PARTITIONS (country = 'US', state = 'CA') TO '/tmp/employee';
-- '/user/hive/warehouse/testdb.db/export/employee'

IMPORT TABLE testdb.employees02 PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee';

ALTER TABLE testdb.employees02 TOUCH;
ALTER TABLE testdb.src_employees02 TOUCH PARTITION (country = 'US', state = 'CA') ;
ALTER TABLE testdb.employees02 TOUCH PARTITION (country = 'US', state = 'CA') ;

DESCRIBE testdb.employees02 PARTITION (country='US', state='CA');
DESCRIBE EXTENDED testdb.employees02 PARTITION (country='US', state='CA');

ALTER TABLE testdb.employees02 CLUSTERED BY (name, address) SORTED BY (salary) INTO 48 BUCKETS;
