--encrypt_db4alter.tbl4rename=encrypt_col3
--CREATE DATABASE encrypt_db4alter;
--DROP DATABASE encrypt_db4alter;

USE encrypt_db4alter;
CREATE TABLE tbl4rename (col1 TINYINT, col2 SMALLINT, encrypt_col3 INT);
SELECT * FROM tbl4rename;
SELECT col1, col2, encrypt_col3 FROM tbl4rename;

ALTER TABLE tbl4rename RENAME TO tbl4rename_new;
SELECT * FROM tbl4rename_new;
SELECT col1, col2, encrypt_col3 FROM tbl4rename_new;

DROP TABLE tbl4rename_new;
