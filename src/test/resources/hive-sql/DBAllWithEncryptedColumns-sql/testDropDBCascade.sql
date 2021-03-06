--CREATE DATABASE encrypt_db4drop_cascade;
--DROP DATABASE encrypt_db4drop_cascade;
--encrypt_db4drop_cascade.encrypt_tbl4drop=encrypt_val

USE encrypt_db4drop_cascade;
CREATE TABLE encrypt_tbl4drop (id INT, encrypt_val STRING);
CREATE VIEW encrypt_view4drop AS SELECT * FROM encrypt_db4drop_cascade.encrypt_tbl4drop;

SELECT * FROM encrypt_db4drop_cascade.encrypt_tbl4drop;
SELECT * FROM encrypt_db4drop_cascade.encrypt_view4drop;

SHOW TABLES LIKE 'encrypt_*4drop';
DROP DATABASE encrypt_db4drop_cascade CASCADE;
SHOW DATABASES LIKE 'encrypt_db4drop_cascade';
