CREATE DATABASE test_db2 WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
CREATE TABLE test_db2.tbl4drop (id INT, val STRING);
CREATE VIEW test_db2.view4drop AS SELECT id, val FROM test_db2.tbl4drop;

USE default;
DROP DATABASE test_db2 CASCADE;
SHOW DATABASES;

DROP DATABASE test_db2 CASCADE;