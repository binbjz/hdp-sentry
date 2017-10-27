USE testdb;

DESCRIBE testdb.tbl4drop;
SHOW CREATE TABLE testdb.tbl4drop;
SHOW CREATE TABLE testdb.view4drop;
SHOW TABLES LIKE '*4drop*';

ALTER VIEW testdb.tbl4drop SET TBLPROPERTIES ('test_table_properties' = 'qa_setting_this_value');
ALTER VIEW testdb.view4drop SET TBLPROPERTIES ('test_view_properties' = 'qa_setting_this_value');
SHOW TBLPROPERTIES testdb.tbl4drop;
SHOW TBLPROPERTIES testdb.view4drop;

CREATE TABLE testdb.tbl4create (col1 TINYINT, col2 SMALLINT);
CREATE EXTERNAL TABLE testdb.tbl4create_external (col1 TINYINT, col2 SMALLINT);
CREATE TABLE testdb.tbl4create_no_privilege (col1 TINYINT, col2 SMALLINT);
CREATE TABLE testdb.ctas AS SELECT * FROM testdb.tbl4drop;

CREATE VIEW testdb.view4create AS SELECT col1, col2 FROM testdb.view4drop;
CREATE VIEW testdb.view4create_no_privilege AS SELECT col1, col2 FROM testdb.view4drop;

SELECT * FROM testdb.tbl4drop_no_r;
SELECT * FROM testdb.view4drop_no_r;

DROP VIEW testdb.view4create;
DROP TABLE testdb.tbl4create;

DROP VIEW testdb.view4create_no_privilege;
DROP TABLE testdb.tbl4create_no_privilege;

DROP VIEW testdb.view4drop;
DROP TABLE testdb.tbl4drop;

DROP TABLE testdb.tbl4create_external;
DROP TABLE testdb.ctas;

SHOW TABLES LIKE '*drop*';
SHOW TABLES LIKE '*create*';
SHOW TABLES LIKE '*ctas';
