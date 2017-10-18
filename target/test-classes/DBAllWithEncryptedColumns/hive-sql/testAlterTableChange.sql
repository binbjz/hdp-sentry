--encrypt_db4alter.tbl4alter=encrypt_col1,encrypt_col2,encrypt_col3
--CREATE DATABASE encrypt_db4alter;
--DROP DATABASE encrypt_db4alter;

USE encrypt_db4alter;
CREATE TABLE tbl4alter (encrypt_col1 TINYINT, encrypt_col2 BIGINT, encrypt_col3 STRING);
SELECT * FROM tbl4alter;
SELECT encrypt_col1, encrypt_col2, encrypt_col3 FROM tbl4alter;

ALTER TABLE tbl4alter CHANGE encrypt_col1 col1to2 INT COMMENT "put column1 to position 2nd" AFTER encrypt_col2;
ALTER TABLE tbl4alter CHANGE encrypt_col3 col3to1 INT COMMENT "put last column to position 1st" FIRST;

DESCRIBE tbl4alter;
SELECT encrypt_col2 FROM tbl4alter;
SELECT * FROM tbl4alter;

DROP TABLE tbl4alter;
