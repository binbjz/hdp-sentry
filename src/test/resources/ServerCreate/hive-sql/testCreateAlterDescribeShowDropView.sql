USE test_db;
CREATE TABLE test_tbl (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);
CREATE VIEW test_view AS SELECT col1, col2, col3, col4, col5, col6, col7, col8, col9 FROM test_tbl;
ALTER VIEW test_view SET TBLPROPERTIES ('created_at' = '20170905');

DESCRIBE test_view;
SHOW CREATE TABLE test_view;
DROP VIEW test_view;
DROP TABLE test_tbl;
