USE test_login_db;

CREATE TABLE test_login_db.tbl4login (name STRING);
INSERT INTO test_login_db.tbl4login VALUES ('test login');
SELECT * FROM test_login_db.tbl4login;
DROP TABLE test_login_db.tbl4login;
DROP DATABASE test_login_db CASCADE;
CREATE DATABASE test_login_db;


USE test_login_db_tbl;

INSERT INTO test_login_db_tbl.test_tbl VALUES ('test login2', 20);
SELECT * FROM test_login_db_tbl.test_tbl ORDER BY name, salary;
DROP TABLE test_login_db_tbl.test_tbl;
CREATE TABLE test_login_db_tbl.test_tbl (
 name STRING
,salary FLOAT
);
