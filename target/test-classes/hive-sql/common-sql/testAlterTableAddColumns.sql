USE testdb;

ALTER TABLE tbl4addcolumns ADD COLUMNS (id STRING);
DESCRIBE tbl4addcolumns;
