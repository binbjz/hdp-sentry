CREATE DATABASE db4create WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
SHOW DATABASES LIKE 'db4create';
CREATE DATABASE db4create WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
ALTER DATABASE db4create SET DBPROPERTIES ('edited-by' = 'hadoop-new-qa');
DESCRIBE DATABASE db4create;
DESCRIBE DATABASE EXTENDED db4create;
DROP DATABASE db4create;
