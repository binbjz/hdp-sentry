--CREATE DATABASE encrypt_db4drop_cascade;
--DROP DATABASE encrypt_db4drop_cascade;
--encrypt_db4drop_cascade.encrypt_tbl4drop=encrypt_id,encrypt_val

USE encrypt_db4drop_cascade;
CREATE TABLE encrypt_tbl4drop (encrypt_id INT, encrypt_val STRING);
CREATE VIEW AS encrypt_view4drop AS SELECT * FROM encrypt_db4drop_cascade.encrypt_tbl4drop;

SELECT * FROM encrypt_db4drop_cascade.encrypt_tbl4drop;
SELECT * FROM encrypt_db4drop_cascade.encrypt_view4drop;

SHOW TABLES;
DROP DATABASE encrypt_db4drop_cascade CASCADE;
SHOW DATABASES LIKE 'encrypt_db4drop_cascade';
