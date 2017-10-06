DROP DATABASE IF EXISTS test_db2 CASCADE;
CREATE DATABASE test_db2;
CREATE TABLE test_db2.employees (
   name STRING
 ,salary FLOAT
 ,subordinates ARRAY<STRING>
  ,deductions MAP<STRING, FLOAT>
  ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING);

CREATE INDEX test_db2.employees_index
ON TABLE test_db2.employees (name)
AS 'org.apache.hadoop.hive.ql.index.compact.CompactIndexHandler'
WITH DEFERRED REBUILD
IDXPROPERTIES ('creator' = 'HADOOP-QA')
IN TABLE test_db2.employees_index_on_name_column
COMMENT 'Employees indexed by name.';

SHOW INDEX ON test_db2.employees;
SHOW FORMATTED INDEX ON test_db2.employees;

DROP INDEX IF EXISTS test_db2.employees_index ON TABLE test_db2.employees;
DROP TABLE test_db2.employees;

DROP DATABASE test_db2;
