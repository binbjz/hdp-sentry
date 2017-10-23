--encrypt_db4data.tbl4builtinfuncs=col1,col2,col3
--CREATE DATABASE encrypt_db4data;
--DROP DATABASE encrypt_db4data;

USE encrypt_db4data;
CREATE TABLE IF NOT EXISTS tbl4builtinfuncs (encrypt_col1 STRING, encrypt_col2 STRING, encrypt_col3 STRING);
INSERT INTO tbl4builtinfuncs VALUES ('lower', 'ab', 'cd,ab,ef'), ('Mixed', 'ab,ef', 'cd,ab,ef'), ('UPPER', 'abc', 'cd,ab,ef');
SELECT repeat(encrypt_col2,2) repeat, ascii(encrypt_col1) ascii, lpad(encrypt_col1, 12, encrypt_col2) lpad, split(encrypt_col3, ',') split, find_in_set(encrypt_col2, encrypt_col3) find_in_set FROM tbl4builtinfuncs;
DROP TABLE tbl4builtinfuncs;
