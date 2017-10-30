USE testdb;

ALTER TABLE tbl4replacecolumns REPLACE COLUMNS (new_col1 INT COMMENT 'new column 1');
DESCRIBE tbl4replacecolumns;
