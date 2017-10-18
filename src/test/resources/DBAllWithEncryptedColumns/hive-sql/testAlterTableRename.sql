--encrypt_db4alter.tbl4alter=encrypt_col1,encrypt_col2,encrypt_col3
--CREATE DATABASE encrypt_db4alter;
--DROP DATABASE encrypt_db4alter;

USE encrypt_db4alter;
CREATE TABLE tbl4alter (encrypt_col1 TINYINT, encrypt_col2 SMALLINT, encrypt_col3 INT);
SELECT * FROM tbl4alter;
SELECT encrypt_col1, encrypt_col2, encrypt_col3 FROM tbl4alter;

ALTER TABLE tbl4alter RENAME TO tbl4alter_new;
SELECT * FROM tbl4alter_new;
SELECT encrypt_col1, encrypt_col2, encrypt_col3 FROM tbl4alter_new;

DROP TABLE tbl4alter_new;
