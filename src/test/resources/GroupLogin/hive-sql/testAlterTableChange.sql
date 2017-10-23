USE mart_waimai;
CREATE TABLE test_tbl (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);
ALTER TABLE test_tbl CHANGE new_col1 new_col1to2 INT COMMENT "put column1 to position 2nd" AFTER new_col2;
ALTER TABLE test_tbl CHANGE new_col3 new_col3to1 INT COMMENT "put last column to position 1st" FIRST;
DESCRIBE test_tbl;
DROP TABLE test_tbl;
