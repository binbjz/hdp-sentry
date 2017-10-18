--encrypt_db4alter.tbl4alter=encrypt_col1,encrypt_col2,encrypt_col3
--CREATE DATABASE encrypt_db4alter;
--DROP DATABASE encrypt_db4alter;

USE encrypt_db4alter;
CREATE TABLE tbl4alter (encrypt_col1 TINYINT, encrypt_col2 BIGINT, encrypt_col3 STRING);
ALTER TABLE tbl4alter ADD COLUMNS (id STRING);

SELECT id FROM tbl4alter;
SELECT encrypt_col1, encrypt_col2, encrypt_col3 FROM tbl4alter;
SELECT * FROM tbl4alter;

DROP TABLE tbl4alter;
