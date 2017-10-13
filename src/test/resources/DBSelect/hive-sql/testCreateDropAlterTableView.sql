USE db4tbl;
SHOW TABLES;
CREATE TABLE db4tbl.tbl2create (col1 TINYINT, col2 SMALLINT);
CREATE VIEW db4tbl.view2create AS SELECT col1, col2 FROM db4tbl.tbl4show;
CREATE TABLE db4tbl.tbl2ctas AS SELECT * FROM db4tbl.tbl4show;
SHOW TABLES;

ALTER TABLE db4tbl.tbl4show SET TBLPROPERTIES ('qa comments' = 'test add table properties');
ALTER VIEW db4tbl.view4show SET TBLPROPERTIES ('qa comments' = 'test add table properties');

DROP VIEW db4tbl.view4show;
DROP TABLE db4tbl.tbl4show;

DESCRIBE EXTENDED db4tbl.tbl4show;
SHOW CREATE TABLE db4tbl.tbl4show;
SHOW CREATE TABLE db4tbl.view4show;
SHOW TABLES;

DROP TABLE db4tbl.tbl4show;
DROP VIEW db4tbl.view4show;
SHOW TABLES;
