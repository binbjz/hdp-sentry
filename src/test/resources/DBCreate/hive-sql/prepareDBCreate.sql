CREATE TABLE tbl4show (col1 TINYINT, col2 SMALLINT);
CREATE VIEW view4show AS SELECT * FROM tbl4show;
CREATE DATABASE db4show WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
