DROP DATABASE IF EXISTS test_db2 CASCADE;
CREATE DATABASE test_db2 WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
SHOW DATABASES LIKE 'test_db2';
DROP DATABASE test_db2;
SHOW DATABASES LIKE 'test_db2';