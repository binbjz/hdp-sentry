CREATE TABLE testDB.employees (
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

CREATE TABLE testDB.staged_employees (
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

ALTER TABLE testDB.employees ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE testDB.staged_employees ADD PARTITION (country = 'US', state = 'CA');

SET FILEPATH=/opt/meituan/qa_test/testfile;
SELECT '${hiveconf:FILEPATH}';
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE testDB.staged_employees
PARTITION (country = 'US', state = 'CA');

EXPORT TABLE testDB.staged_employees PARTITIONS (country = 'US', state = 'CA') TO '/tmp/employee';

IMPORT TABLE testDB.employees PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee';

ALTER TABLE testDB.employees TOUCH;


ALTER TABLE testDB.staged_employees TOUCH PARTITION (country = 'US', state = 'CA') ;
ALTER TABLE testDB.employees TOUCH PARTITION (country = 'US', state = 'CA') ;
ALTER TABLE testDB.employees ADD PARTITION (country = 'CHN', state = 'BJ') ;
ALTER TABLE testDB.employees TOUCH PARTITION (country = 'CHN', state = 'BJ') ;

DESCRIBE testDB.employees PARTITION (country='US', state='CA');
DESCRIBE EXTENDED testDB.employees PARTITION (country='US', state='CA');

ALTER TABLE testDB.employees CLUSTERED BY (name, address) SORTED BY (salary) INTO 48 BUCKETS;
