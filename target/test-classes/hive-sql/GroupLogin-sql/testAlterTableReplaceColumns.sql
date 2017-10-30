USE mart_waimai;

ALTER TABLE mart_waimai.test_replace_columns REPLACE COLUMNS (new_col1 INT COMMENT 'new column 1' , new_col2 STRING COMMENT 'new column 2');
DESCRIBE test_replace_columns;
