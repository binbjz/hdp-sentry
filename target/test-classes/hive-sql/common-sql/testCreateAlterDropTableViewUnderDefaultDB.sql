USE default;

DESCRIBE tbl4drop;
SHOW CREATE TABLE tbl4drop;
SHOW CREATE TABLE view4drop;
SHOW TABLES LIKE '*4drop*';

ALTER VIEW tbl4drop SET TBLPROPERTIES ('test_table_properties' = 'qa_setting_this_value');
ALTER VIEW view4drop SET TBLPROPERTIES ('test_view_properties' = 'qa_setting_this_value');
SHOW TBLPROPERTIES tbl4drop;
SHOW TBLPROPERTIES view4drop;

CREATE TABLE tbl4create (col1 TINYINT, col2 SMALLINT);
CREATE EXTERNAL TABLE tbl4create_external (col1 TINYINT, col2 SMALLINT);
CREATE TABLE tbl4create_no_privilege (col1 TINYINT, col2 SMALLINT);
CREATE TABLE ctas AS SELECT * FROM testdb.tbl4drop;

CREATE VIEW view4create AS SELECT col1, col2 FROM view4drop;
CREATE VIEW view4create_no_privilege AS SELECT col1, col2 FROM view4drop;

SELECT * FROM tbl4drop_no_r;
SELECT * FROM view4drop_no_r;


DROP VIEW view4create;
DROP TABLE tbl4create;

DROP VIEW view4create_no_privilege;
DROP TABLE tbl4create_no_privilege;

DROP VIEW view4drop;
DROP TABLE tbl4drop;

DROP TABLE tbl4create_external;
DROP TABLE ctas;

SHOW TABLES LIKE '*drop*';
SHOW TABLES LIKE '*create*';
SHOW TABLES LIKE '*ctas';
