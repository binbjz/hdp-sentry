--encrypt_db4alter.tbl4replace=encrypt_col1,encrypt_col2,encrypt_col3
--CREATE DATABASE encrypt_db4alter;
--DROP DATABASE encrypt_db4alter;

USE encrypt_db4alter;
CREATE TABLE tbl4replace (encrypt_col1 TINYINT, encrypt_col2 BIGINT, encrypt_col3 STRING);
INSERT INTO tbl4replace VALUES (1, 2, 'column 3');
SELECT * FROM tbl4replace;

ALTER TABLE tbl4replace REPLACE COLUMNS (new_col1 INT COMMENT 'new column 1' , new_col2 STRING COMMENT 'new column 2', new_col3 STRING COMMENT 'new column3');
SELECT * FROM tbl4replace;
SELECT new_col1, new_col2, new_col3 FROM tbl4replace;
DESCRIBE tbl4replace;

DROP TABLE tbl4replace;
