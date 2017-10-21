--encrypt_db4alter.tbl4change=encrypt_col1,encrypt_col2,encrypt_col3
--CREATE DATABASE encrypt_db4alter;
--DROP DATABASE encrypt_db4alter;

USE encrypt_db4alter;
CREATE TABLE tbl4change (encrypt_col1 TINYINT, encrypt_col2 BIGINT, encrypt_col3 STRING);
SELECT * FROM tbl4change;
SELECT encrypt_col1, encrypt_col2, encrypt_col3 FROM tbl4change;

INSERT INTO tbl4change VALUES (1, 2, 'column3');

ALTER TABLE tbl4change CHANGE encrypt_col1 col1to2 INT COMMENT "put column1 to position 2nd" AFTER encrypt_col2;
ALTER TABLE tbl4change CHANGE encrypt_col3 col3to1 INT COMMENT "put last column to position 1st" FIRST;

DESCRIBE tbl4change;
SELECT encrypt_col2 FROM tbl4change;
SELECT * FROM tbl4change;

DROP TABLE tbl4change;
