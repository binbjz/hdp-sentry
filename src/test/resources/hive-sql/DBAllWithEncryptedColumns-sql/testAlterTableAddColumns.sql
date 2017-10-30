--encrypt_db4alter.tbl4addcolumn=encrypt_col2
--CREATE DATABASE encrypt_db4alter;
--DROP DATABASE encrypt_db4alter;

USE encrypt_db4alter;
CREATE TABLE tbl4addcolumn (col1 TINYINT, encrypt_col2 BIGINT, col3 STRING);
INSERT INTO tbl4addcolumn VALUES (1, 2, 3), (2, 4, 6);
ALTER TABLE tbl4addcolumn ADD COLUMNS (id STRING);

DESC tbl4addcolumn;
SELECT id FROM tbl4addcolumn;
SELECT col1, encrypt_col2, col3 FROM tbl4addcolumn;
SELECT * FROM tbl4addcolumn;

DROP TABLE tbl4addcolumn;
