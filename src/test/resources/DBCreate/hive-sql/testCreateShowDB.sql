CREATE DATABASE db2create WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
CREATE DATABASE db4create WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
USE default;
SHOW DATABASES;
ALTER DATABASE db4show SET DBPROPERTIES ('edited-by' = 'hadoop-new-qa');
DESCRIBE DATABASE EXTENDED db4show;
