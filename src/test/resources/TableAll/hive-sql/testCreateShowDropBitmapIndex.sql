USE testDB;

CREATE INDEX employees_bitmap_index
ON TABLE employees (subordinates)
AS 'BITMAP' WITH DEFERRED REBUILD
IDXPROPERTIES ('creator' = 'me')
IN TABLE employees_bitmap_index_table
-- PARTITIONED BY (country, name) ??
COMMENT 'Employees indexed by country and name.';

SHOW INDEX ON employees;
SHOW FORMATTED INDEX ON employees;

DROP INDEX IF EXISTS employees_bitmap_index ON TABLE employees;
