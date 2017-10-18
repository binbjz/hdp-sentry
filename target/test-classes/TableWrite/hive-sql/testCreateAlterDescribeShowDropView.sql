USE testdb;
SHOW TABLES LIKE 'tbl4alter*';
ALTER TABLE tbl4alter ADD COLUMNS (id STRING);
DESCRIBE tbl4alter;
ALTER TABLE tbl4alter REPLACE COLUMNS (new_col1 INT COMMENT 'new column 1' , new_col2 STRING COMMENT 'new column 2', new_col3 STRING COMMENT 'new column3');
DESCRIBE tbl4alter;
ALTER TABLE tbl4alter CHANGE new_col1 new_col1to2 INT COMMENT "put column1 to position 2nd" AFTER new_col2;
ALTER TABLE tbl4alter CHANGE new_col3 new_col3to1 INT COMMENT "put last column to position 1st" FIRST;
DESCRIBE tbl4alter;
ALTER TABLE tbl4alter SET TBLPROPERTIES ('notes' = 'Test for set tblproperties');
SHOW TBLPROPERTIES tbl4alter;
ALTER TABLE tbl4alter RENAME TO tbl4alter_new;
SHOW TABLES LIKE 'tbl4alter*'; -- no table show up due to no privilege on new table
