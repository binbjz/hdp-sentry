USE testDB;
SHOW TABLES LIKE '*drop';

CREATE TABLE tbl2create (col1 TINYINT);
CREATE VIEW view2create AS SELECT * FROM tbl4drop;
ALTER TABLE tbl4drop SET TBLPROPERTIES ('updated_at' = '20170905');
ALTER VIEW view4drop SET TBLPROPERTIES ('updated_at' = '20170905');
DROP VIEW view4drop;
DROP TABLE tbl4drop;
DESCRIBE tbl4drop;
DESCRIBE view4drop;
SHOW CREATE TABLE tbl4drop;
SHOW CREATE TABLE view4drop;
