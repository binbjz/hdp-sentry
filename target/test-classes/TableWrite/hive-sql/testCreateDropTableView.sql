--DROP VIEW testdb.view2create;
--DROP TABLE testdb.tbl2create;
--DROP VIEW testdb.view4drop_no_r;
--DROP TABLE testdb.tbl4drop_no_r;
--DROP VIEW testdb.view4drop;
--DROP TABLE testdb.tbl4drop;

DESCRIBE testdb.tbl4drop;
SHOW CREATE TABLE testdb.view4drop;
SHOW TABLES LIKE '*4drop*';
ALTER VIEW testdb.view4drop SET TBLPROPERTIES ('test_table_properties' = 'qa_setting_this_value');
SHOW TBLPROPERTIES testdb.view4drop;
CREATE TABLE testdb.tbl2create (col1 TINYINT, col2 SMALLINT);
CREATE VIEW testdb.view2create AS SELECT col1, col2 FROM testdb.view4drop;
CREATE VIEW testdb.view2create_no_r AS SELECT col1, col2 FROM testdb.view4drop_no_r;

DROP VIEW testdb.view2create;
DROP TABLE testdb.tbl2create;
DROP VIEW testdb.view4drop_no_r;
DROP TABLE testdb.tbl4drop_no_r;
DROP VIEW testdb.view4drop;
DROP TABLE testdb.tbl4drop;

USE testdb;
SHOW TABLES LIKE '*4drop*';
SHOW TABLES LIKE '*2create';
