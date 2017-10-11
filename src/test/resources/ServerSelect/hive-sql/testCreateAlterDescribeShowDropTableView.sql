USE testdb;
SHOW TABLES LIKE '*drop';
SHOW CREATE TABLE tbl4drop;
SHOW CREATE TABLE view4drop;
DESCRIBE view4drop;
DESCRIBE EXTENDED view4drop;
DROP VIEW view4drop;
CREATE TABLE tbl4create (col1 TINYINT, col2 SMALLINT);
CREATE VIEW view4create AS SELECT col1, col2 FROM tbl4drop;

ALTER VIEW view4drop SET TBLPROPERTIES ('created_at' = '20170905');
DROP TABLE tbl4drop;
DROP VIEW view4drop;
