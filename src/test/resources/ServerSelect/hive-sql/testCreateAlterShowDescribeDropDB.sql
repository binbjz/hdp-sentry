CREATE DATABASE db2create WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
ALTER DATABASE db4drop SET DBPROPERTIES ('edited-by' = 'hadoop-new-qa');
SHOW DATABASES LIKE 'db2create';
SHOW DATABASES;
DROP DATABASE db4drop;
DESCRIBE DATABASE db4drop;
DESCRIBE DATABASE EXTENDED db4drop;
