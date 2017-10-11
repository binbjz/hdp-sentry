<<<<<<< HEAD
USE testdb;

=======
>>>>>>> b0450854b2f7ed1c2e1b2c8651afe9e2db333a37
CREATE TABLE testdb.employees (
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

CREATE TABLE testdb.staged_employees (
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

ALTER TABLE testdb.employees ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE testdb.staged_employees ADD PARTITION (country = 'US', state = 'CA');

SET FILEPATH=/opt/meituan/qa_test/testfile;
SELECT '${hiveconf:FILEPATH}';
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE testdb.staged_employees
PARTITION (country = 'US', state = 'CA');

EXPORT TABLE testdb.staged_employees PARTITIONS (country = 'US', state = 'CA') TO '/tmp/employee';
<<<<<<< HEAD

IMPORT TABLE testdb.employees PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee';
=======

IMPORT TABLE testdb.employees PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee';

ALTER TABLE testdb.employees TOUCH;
>>>>>>> b0450854b2f7ed1c2e1b2c8651afe9e2db333a37

ALTER TABLE testdb.employees TOUCH;

ALTER TABLE testdb.staged_employees TOUCH PARTITION (country = 'US', state = 'CA') ;
ALTER TABLE testdb.employees TOUCH PARTITION (country = 'US', state = 'CA') ;
ALTER TABLE testdb.employees ADD PARTITION (country = 'CHN', state = 'BJ') ;
ALTER TABLE testdb.employees TOUCH PARTITION (country = 'CHN', state = 'BJ') ;

DESCRIBE testdb.employees PARTITION (country='US', state='CA');
DESCRIBE EXTENDED testdb.employees PARTITION (country='US', state='CA');

ALTER TABLE testdb.employees CLUSTERED BY (name, address) SORTED BY (salary) INTO 48 BUCKETS;
