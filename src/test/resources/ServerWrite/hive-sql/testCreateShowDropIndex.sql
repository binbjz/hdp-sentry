DROP DATABASE IF EXISTS testdb CASCADE;
CREATE DATABASE testdb;
CREATE TABLE testdb.employees (
   name STRING
 ,salary FLOAT
 ,subordinates ARRAY<STRING>
  ,deductions MAP<STRING, FLOAT>
  ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING);

CREATE INDEX testdb.employees_index
ON TABLE testdb.employees (name)
AS 'org.apache.hadoop.hive.ql.index.compact.CompactIndexHandler'
WITH DEFERRED REBUILD
IDXPROPERTIES ('creator' = 'HADOOP-QA')
IN TABLE testdb.employees_index_on_name_column
COMMENT 'Employees indexed by name.';

SHOW INDEX ON testdb.employees;
SHOW FORMATTED INDEX ON testdb.employees;

DROP INDEX IF EXISTS testdb.employees_index ON TABLE testdb.employees;
DROP TABLE testdb.employees;

DROP DATABASE testdb;
