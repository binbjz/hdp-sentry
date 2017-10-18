--encrypt_db4data.testbuiltinfuncs=col1,col2,col3
--CREATE DATABASE encrypt_db4data;
--DROP DATABASE encrypt_db4data;

USE encrypt_db4data;
CREATE TABLE IF NOT EXISTS testbuiltinfuncs (col1 STRING, col2 STRING, col3 STRING);
INSERT INTO testbuiltinfuncs VALUES ('lower', 'ab', 'cd,ab,ef'), ('Mixed', 'ab,ef', 'cd,ab,ef'), ('UPPER', 'abc', 'cd,ab,ef');
SELECT repeat(col2,2) repeat, ascii(col1) ascii, lpad(col1, 12, col2) lpad, split(col3, ',') split, find_in_set(col2, col3) find_in_set FROM testbuiltinfuncs;
DROP TABLE testbuiltinfuncs;
