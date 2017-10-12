USE testdb;
SHOW TABLES LIKE '*drop';

CREATE TABLE tbl2create (col1 TINYINT);
CREATE VIEW view2create AS SELECT * FROM tbl4drop;
ALTER TABLE tbl4drop SET TBLPROPERTIES ('updated_at' = '20170905');
ALTER VIEW view4drop SET TBLPROPERTIES ('updated_at' = '20170905');
SHOW TBLPROPERTIES tbl4drop;
SHOW view4drop tbl4drop;
DROP VIEW view4drop;
DROP TABLE tbl4drop;
SHOW TABLES LIKE '*4drop';
SHOW TABLES LIKE '*2create';
