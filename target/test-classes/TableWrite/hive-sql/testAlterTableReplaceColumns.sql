USE testdb;
ALTER TABLE tbl4replacecolumns REPLACE COLUMNS (new_col1 INT COMMENT 'new column 1' , new_col2 STRING COMMENT 'new column 2', new_col3 STRING COMMENT 'new column3');
DESCRIBE tbl4replacecolumns;
