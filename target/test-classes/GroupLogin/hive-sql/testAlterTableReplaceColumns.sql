USE mart_waimai;
ALTER TABLE test_replace_columns REPLACE COLUMNS (new_col1 INT COMMENT 'new column 1' , new_col2 STRING COMMENT 'new column 2', new_col3 STRING COMMENT 'new column3');
DESCRIBE test_replace_columns;
