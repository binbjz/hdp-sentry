--testLoginMethod.sql
USE test_group_db1;

CREATE TABLE test_group_db1.tbl4group (name STRING);
INSERT INTO test_group_db1.tbl4group VALUES ('test group1');
SELECT * FROM test_group_db1.tbl4group;
DROP TABLE test_group_db1.tbl4group;

USE test_group_db2;

CREATE TABLE test_group_db2.tbl4group (name STRING);
INSERT INTO test_group_db2.tbl4group VALUES ('test group1');
SELECT * FROM test_group_db2.tbl4group;
DROP TABLE test_group_db2.tbl4group;

USE test_user_db;

CREATE TABLE test_user_db.tbl4user (name STRING);
INSERT INTO test_user_db.tbl4user VALUES ('test user');
SELECT * FROM test_user_db.tbl4user;
DROP TABLE test_user_db.tbl4user;
