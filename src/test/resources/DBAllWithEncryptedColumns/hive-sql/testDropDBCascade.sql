USE encrypt_db4drop_cascade;
DESCRIBE DATABASE EXTENDED encrypt_db4drop_cascade;
ALTER DATABASE encrypt_db4drop_cascade SET DBPROPERTIES ('edited-by' = 'hadoop-new-qa');
DESCRIBE DATABASE EXTENDED encrypt_db4drop_cascade;

SELECT col1, col2 FROM encrypt_db4drop_cascade.encrypt_view1;
SELECT col1 FROM encrypt_db4drop_cascade.encrypt_view2;

SELECT encrypt_column FROM encrypt_tbl1;
SELECT encrypt_column1, encrypt_column2 FROM encrypt_tbl2;
SELECT col1, col2, encrypt_column FROM encrypt_db4drop_cascade.encrypt_view1;
SELECT col1, encrypt_column1, encrypt_column2 FROM encrypt_db4drop_cascade.encrypt_view2;

SHOW TABLES;
DROP VIEW encrypt_db4drop_cascade.encrypt_view2;
DROP TABLE encrypt_db4drop_cascade.encrypt_tbl2;
SHOW TABLES;
DROP DATABASE encrypt_db4drop_cascade CASCADE;
SHOW DATABASES LIKE 'encrypt_db4drop_cascade';
