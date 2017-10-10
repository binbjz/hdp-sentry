--Execution:
CREATE TABLE testDB.employees (
  name STRING
 ,salary FLOAT
 ,subordinates ARRAY<STRING>
 ,deductions MAP<STRING, FLOAT>
 ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING);

CREATE INDEX testDB.employees_index
ON TABLE testDB.employees (name)
AS 'org.apache.hadoop.hive.ql.index.compact.CompactIndexHandler'
WITH DEFERRED REBUILD
IDXPROPERTIES ('creator' = 'HADOOP-QA')
IN TABLE testDB.employees_index_on_name_column
COMMENT 'Employees indexed by name.';

SHOW INDEX ON testDB.employees;
SHOW FORMATTED INDEX ON testDB.employees;

DROP INDEX IF EXISTS testDB.employees_index ON TABLE testDB.employees;
DROP TABLE testDB.employees;
