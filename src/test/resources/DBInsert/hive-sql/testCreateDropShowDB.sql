CREATE DATABASE db4show WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');

USE default;
CREATE DATABASE db2create WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
DESCRIBE DATABASE db4show;
DROP DATABASE db4show;
SHOW DATABASES;

DROP DATABASE db4show;