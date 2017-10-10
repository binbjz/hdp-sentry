CREATE TABLE test_db.employees (
  name STRING
 ,salary FLOAT
 ,subordinates ARRAY<STRING>
 ,deductions MAP<STRING, FLOAT>
 ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
COLLECTIONS ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;

CREATE TABLE test_db.staged_employees (
  name STRING
 ,salary FLOAT
 ,subordinates ARRAY<STRING>
 ,deductions MAP<STRING, FLOAT>
 ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;

ALTER TABLE test_db.employees ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE test_db.staged_employees ADD PARTITION (country = 'US', state = 'CA');

SET FILEPATH=/opt/meituan/qa_test/testfile;
SELECT '${hiveconf:FILEPATH}';
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE test_db.staged_employees
PARTITION (country = 'US', state = 'CA');

-- 导出分区并且导入到分区表分区
EXPORT TABLE test_db.staged_employees PARTITIONS (country = 'US', state = 'CA') TO '/tmp/employee';
-- '/user/hive/warehouse/test_db.db/export/employee'

IMPORT TABLE test_db.employees PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee';

ALTER TABLE test_db.employees TOUCH;

ALTER TABLE test_db.staged_employees TOUCH PARTITION (country = 'US', state = 'CA') ;
ALTER TABLE test_db.employees TOUCH PARTITION (country = 'US', state = 'CA') ;
ALTER TABLE test_db.employees ADD PARTITION (country = 'CHN', state = 'BJ') ;
ALTER TABLE test_db.employees TOUCH PARTITION (country = 'CHN', state = 'BJ') ;

DESCRIBE test_db.employees PARTITION (country='US', state='CA');
DESCRIBE EXTENDED test_db.employees PARTITION (country='US', state='CA');

ALTER TABLE test_db.employees CLUSTERED BY (name, address) SORTED BY (salary) INTO 48 BUCKETS;
