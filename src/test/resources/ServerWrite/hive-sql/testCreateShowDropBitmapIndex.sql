--DROP INDEX IF EXISTS employees_bitmap_index ON TABLE employees;
--DROP TABLE employees;
--DROP DATABASE testdb;
--DROP DATABASE IF EXISTS testdb CASCADE;

CREATE DATABASE testdb;

USE testdb;
CREATE TABLE employees (
  name STRING
 ,salary FLOAT
 ,subordinates ARRAY<STRING>
 ,deductions MAP<STRING, FLOAT>
 ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING);

CREATE INDEX employees_bitmap_index
ON TABLE employees (subordinates)
AS 'BITMAP' WITH DEFERRED REBUILD
IDXPROPERTIES ('creator' = 'me')
IN TABLE employees_bitmap_index_table
COMMENT 'Employees indexed by country and name.';

SHOW INDEX ON employees;
SHOW FORMATTED INDEX ON employees;

DROP INDEX IF EXISTS employees_bitmap_index ON TABLE employees;
DROP TABLE employees;

DROP DATABASE testdb;
