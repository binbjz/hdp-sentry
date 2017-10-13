CREATE DATABASE unaccessibledb;
CREATE DATABASE db4drop WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
CREATE DATABASE db2drop WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');

CREATE TABLE default.tbl4show (col1 STRING);
CREATE VIEW default.view4show AS SELECT * FROM default.tbl4show;
