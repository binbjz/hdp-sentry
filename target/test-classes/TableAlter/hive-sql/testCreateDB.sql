USE default;

CREATE DATABASE db4create WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
CREATE DATABASE db4create_no_privilege WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
SHOW DATABASES LIKE 'db4create*';
