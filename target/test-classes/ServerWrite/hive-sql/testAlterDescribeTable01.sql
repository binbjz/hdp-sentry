--DROP DATABASE db4alter CASCADE;
--DROP DATABASE IF EXISTS db4alter CASCADE;


CREATE DATABASE db4alter WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
USE db4alter;
CREATE TABLE test_tbl (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);
ALTER TABLE test_tbl ADD COLUMNS (id STRING);
DESCRIBE test_tbl;
ALTER TABLE test_tbl REPLACE COLUMNS (new_col1 INT COMMENT 'new column 1' , new_col2 STRING COMMENT 'new column 2', new_col3 STRING COMMENT 'new column3');
SHOW CREATE TABLE test_tbl;
ALTER TABLE test_tbl CHANGE new_col1 new_col1to2 INT COMMENT "put column1 to position 2nd" AFTER new_col2;
ALTER TABLE test_tbl CHANGE new_col3 new_col3to1 INT COMMENT "put last column to position 1st" FIRST;
DESCRIBE test_tbl;
ALTER TABLE test_tbl RENAME TO test_tbl_new;
ALTER TABLE test_tbl_new SET TBLPROPERTIES ('notes' = 'Test for set tblproperties');
DESCRIBE EXTENDED test_tbl_new;

