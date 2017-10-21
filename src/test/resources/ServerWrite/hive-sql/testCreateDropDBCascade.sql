--DROP DATABASE db2drop_cascade CASCADE;
--DROP DATABASE IF EXISTS db2drop_cascade CASCADE;

CREATE DATABASE db2drop_cascade WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
SHOW DATABASES LIKE 'db2drop_cascade';
CREATE TABLE db2drop_cascade.tbl4drop (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);
CREATE VIEW db2drop_cascade.view4drop AS SELECT col1, col2, col3, col4, col5, col6, col7, col8, col9 FROM db2drop_cascade.tbl4drop;
USE db2drop_cascade;
SHOW TABLES;
DROP DATABASE db2drop_cascade CASCADE;
SHOW DATABASES LIKE 'db2drop_cascade';
