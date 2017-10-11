USE testdb;
ALTER TABLE test_tbl ADD COLUMNS (id STRING);
DESCRIBE test_tbl;

ALTER TABLE test_tbl REPLACE COLUMNS (new_col1 INT COMMENT 'new column 1' , new_col2 STRING COMMENT 'new column 2', new_col3 STRING COMMENT 'new column3');
SHOW CREATE TABLE test_tbl;

ALTER TABLE test_tbl CHANGE new_col1 new_col1to2 INT COMMENT "put column1 to position 2nd" AFTER new_col2;
ALTER TABLE test_tbl CHANGE new_col3 new_col3to1 INT COMMENT "put last column to position 1st" FIRST;
--ALTER TABLE test_tbl CHANGE col1 new_col1to2 INT COMMENT "put column1 to position 2nd" AFTER col2;

DESCRIBE test_tbl;
ALTER TABLE test_tbl RENAME TO test_tbl_new;
<<<<<<< HEAD
ALTER TABLE test_tbl_new SET TBLPROPERTIES ('notes' = 'Test for set tblproperties');
=======
ALTER TABLE test_tbl SET TBLPROPERTIES ('notes' = 'Test for set tblproperties');
>>>>>>> b0450854b2f7ed1c2e1b2c8651afe9e2db333a37
SHOW TBLPROPERTIES test_tbl_new;
