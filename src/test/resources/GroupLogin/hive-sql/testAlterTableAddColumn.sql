USE mart_waimai;
CREATE TABLE test_tbl (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);
ALTER TABLE test_tbl ADD COLUMNS (id STRING);
DESCRIBE test_tbl;
DROP TABLE test_tbl_new;
