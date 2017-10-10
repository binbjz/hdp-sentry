--Execution:
DESCRIBE testDB.tbl4drop;
SHOW CREATE TABLE testDB.view4drop;
SHOW TABLES LIKE '*4drop*';
ALTER VIEW testDB.view4drop SET TBLPROPERTIES ('test_table_properties' = 'qa_setting_this_value');
SHOW TBLPROPERTIES testDB.view4drop;
CREATE TABLE testDB.tbl2create (col1 TINYINT, col2 SMALLINT);
CREATE VIEW testDB.view2create AS SELECT col1, col2 FROM testDB.view4drop;
CREATE VIEW testDB.view2create_no_r AS SELECT col1, col2 FROM testDB.view4drop_no_r;
USE testDB;
DROP VIEW view2create;
DROP TABLE tbl2create;
DROP VIEW view4drop_no_r;
DROP TABLE tbl4drop_no_r;
DROP VIEW view4drop;
DROP TABLE tbl4drop;
SHOW TABLES;
SHOW TABLES LIKE '*2create';
