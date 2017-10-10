SHOW DATABASES LIKE 'db4show';
DROP DATABASE db4show;
CREATE DATABASE db2create WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
USE db4show;
ALTER DATABASE db4show SET DBPROPERTIES ('edited-by' = 'hadoop-new-qa');
DESCRIBE DATABASE EXTENDED db4show;
