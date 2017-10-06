DROP DATABASE IF EXISTS db4data CASCADE;
CREATE DATABASE db4data;
CREATE TABLE db4data.staged_employees (
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

CREATE TABLE db4data.employees (
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

ALTER TABLE db4data.staged_employees ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE db4data.staged_employees ADD PARTITION (country = 'US', state = 'OR');
ALTER TABLE db4data.staged_employees ADD PARTITION (country = 'US', state = 'IL');


LOAD DATA LOCAL INPATH '${env:FILEPATH}/california-employees.csv'
INTO TABLE db4data.staged_employees
PARTITION (country = 'US', state = 'CA');

SELECT * FROM db4data.staged_employees;

FROM db4data.staged_employees se
INSERT OVERWRITE TABLE db4data.employees PARTITION (country = 'US', state = 'OR')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'OR'
INSERT OVERWRITE TABLE db4data.employees PARTITION (country = 'US', state = 'IL')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'IL'
INSERT OVERWRITE TABLE db4data.employees PARTITION (country = 'US', state = 'CA')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'CA';

SET hive.cli.print.header=true;
SELECT * FROM db4data.employees;


INSERT OVERWRITE TABLE db4data.employees PARTITION (country = 'US', state = 'CA')
SELECT name, salary, subordinates, deductions, address FROM db4data.staged_employees se WHERE se.country = 'US' AND se.state = 'CA';
SELECT * FROM db4data.employees;


SET hive.exec.dynamic.partition=true;
SET hive.vectorized.execution.enabled = true;
SET hive.vectorized.execution.reduce.enabled = true;
INSERT OVERWRITE TABLE db4data.employees PARTITION (country = 'US', state)
SELECT se.name, se.salary, se.subordinates, se.deductions, se.address, se.state FROM db4data.staged_employees se WHERE se.country = 'US';
SELECT * FROM db4data.employees;

INSERT OVERWRITE LOCAL DIRECTORY '/tmp/ca_employees'
SELECT * FROM db4data.staged_employees se WHERE se.country = 'US' and se.state = 'CA';
!ls -l /tmp/ca_employees;
!rm -r /tmp/ca_employees;

FROM (
      SELECT emp.name, emp.salary FROM db4data.staged_employees emp WHERE emp.salary < 6000
      UNION ALL
      SELECT emp.name, emp.salary FROM db4data.staged_employees emp WHERE emp.salary > 7000
) unioninput
INSERT OVERWRITE DIRECTORY '/tmp/union.out' SELECT unioninput.*;
dfs -cat /tmp/union.out/* ;
dfs -rm -r /tmp/union.out ;

ANALYZE TABLE db4data.staged_employees COMPUTE STATISTICS FOR columns name, salary;
ANALYZE TABLE db4data.staged_employees PARTITION (country = 'US', state = 'CA') COMPUTE STATISTICS;
ANALYZE TABLE db4data.staged_employees PARTITION (country = 'US', state)  COMPUTE STATISTICS;
ANALYZE TABLE db4data.staged_employees PARTITION (country, state) COMPUTE STATISTICS;
DESCRIBE EXTENDED db4data.staged_employees;
DESCRIBE EXTENDED db4data.staged_employees PARTITION (country = 'US', state = 'CA');

DROP TABLE db4data.staged_employees;
DROP TABLE db4data.employees;

DROP DATABASE db4data;