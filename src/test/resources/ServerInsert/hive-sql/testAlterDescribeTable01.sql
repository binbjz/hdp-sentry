USE testdb;
ALTER TABLE tbl4alter ADD COLUMNS (id STRING);
DESCRIBE tbl4alter;
ALTER TABLE tbl4alter REPLACE COLUMNS (new_col1 INT COMMENT 'new column 1' , new_col2 STRING COMMENT 'new column 2', new_col3 STRING COMMENT 'new column3');
ALTER TABLE tbl4alter CHANGE col1 new_col1 INT COMMENT "put column1 to position 2nd" AFTER col2;
ALTER TABLE tbl4alter RENAME TO test_tbl_new;
ALTER TABLE tbl4alter SET TBLPROPERTIES ('notes' = 'Test for set tblproperties');
