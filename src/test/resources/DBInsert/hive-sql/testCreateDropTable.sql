--Precondition:
CREATE DATABASE db4tbl WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
CREATE TABLE db4tbl.tbl4show (id INT, val STRING);
CREATE VIEW db4tbl.view4show AS SELECT id, val FROM db4tbl.tbl4show;

--Execution:
USE db4tbl;
CREATE TABLE tbl2create (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);
CREATE VIEW db4tbl.view2create AS SELECT id, val FROM db4tbl.tbl4show;
SHOW TABLES;
DESCRIBE db4tbl.tbl4show;
DESCRIBE db4tbl.view4show;
ALTER VIEW db4tbl.view4show SET TBLPROPERTIES ('created_at' = '20170905');
DROP VIEW db4tbl.view4show;
DROP TABLE db4tbl.tbl4show;

--Cleanup:
DROP VIEW db4tbl.view4show;
DROP TABLE db4tbl.tbl4show;
DROP DATABASE db4tbl;