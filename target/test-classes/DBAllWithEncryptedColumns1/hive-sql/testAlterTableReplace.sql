USE encrypt_db4alter;
CREATE TABLE tbl4alter (encrypt_col1 TINYINT, encrypt_col2 BIGINT, encrypt_col3 STRING);

ALTER TABLE tbl4alter REPLACE COLUMNS (new_col1 INT COMMENT 'new column 1' , new_col2 STRING COMMENT 'new column 2', new_col3 STRING COMMENT 'new column3');
SELECT * FROM tbl4alter;
DESCRIBE tbl4alter;
DROP TABLE tbl4alter;
