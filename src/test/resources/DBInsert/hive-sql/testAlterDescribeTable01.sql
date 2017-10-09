--Precondition:
CREATE DATABASE db4alter WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
USE db4alter;
CREATE TABLE tbl4alter (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);

--Execution:
USE db4alter;
ALTER TABLE db4alter.tbl4alter ADD COLUMNS (id STRING);
ALTER TABLE tbl4alter REPLACE COLUMNS (new_col1 INT COMMENT 'new column 1' , new_col2 STRING COMMENT 'new column 2', new_col3 STRING COMMENT 'new column3');
ALTER TABLE tbl4alter CHANGE col1 new_col1to2 INT COMMENT "put column1 to position 2nd" AFTER col2;
ALTER TABLE tbl4alter CHANGE col3 new_col3to1 INT COMMENT "put last column to position 1st" FIRST;
ALTER TABLE tbl4alter RENAME TO tbl4alter_new;
ALTER TABLE tbl4alter SET TBLPROPERTIES ('notes' = 'Test for set tblproperties');
DESCRIBE EXTENDED tbl4alter;

--Cleanup:
DROP DATABASE db4alter CASCADE;