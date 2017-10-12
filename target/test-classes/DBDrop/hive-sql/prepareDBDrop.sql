CREATE DATABASE unaccessibledb;
CREATE DATABASE db4drop WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
CREATE DATABASE db2drop WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
CREATE DATABASE db4drop_cascade WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
CREATE TABLE db4drop_cascade.test_tbl (col1 TINYINT, col2 SMALLINT);
CREATE VIEW db4drop_cascade.test_view AS SELECT col1, col2 FROM db4drop_cascade.test_tbl;
CREATE TABLE default.tbl4show (col1 TINYINT, col2 SMALLINT);
CREATE VIEW default.view4show AS SELECT col1, col2 FROM default.tbl4show;