USE default;
SHOW TABLES;
CREATE TABLE default.tbl2create (col1 TINYINT, col2 SMALLINT);
CREATE VIEW default.view2create AS SELECT col1, col2 FROM default.tbl4show;
DROP TABLE default.tbl4show;
SHOW TABLES;
