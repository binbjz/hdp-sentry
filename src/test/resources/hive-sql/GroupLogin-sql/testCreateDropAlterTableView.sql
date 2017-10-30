USE mart_waimai;

SHOW TABLES;
CREATE TABLE mart_waimai.tbl2create (col1 TINYINT, col2 SMALLINT);
CREATE VIEW mart_waimai.view2create_star AS SELECT * FROM origin_waimai.waimai_cos__wm_employ;
CREATE VIEW mart_waimai.view2create_non_encrypt_columns AS SELECT * FROM origin_waimai.waimai_cos__wm_employ;
CREATE VIEW mart_waimai.view2create_encrypt_columns AS SELECT email, mobile FROM origin_waimai.waimai_cos__wm_employ;

SHOW TABLES;
ALTER TABLE mart_waimai.tbl2create SET TBLPROPERTIES ('qa comments' = 'test add table properties');
ALTER VIEW mart_waimai.view2create_non_encrypt_columns SET TBLPROPERTIES ('qa comments' = 'test add table properties');

SHOW TABLES LIKE '*2create*';
DROP VIEW mart_waimai.view2create_star;
DROP VIEW mart_waimai.view2create_non_encrypt_columns;
DROP VIEW mart_waimai.view2create_encrypt_columns;

DROP TABLE mart_waimai.tbl2create;
DESCRIBE EXTENDED mart_waimai.tbl2create;
SHOW CREATE TABLE mart_waimai.tbl2create;
SHOW CREATE TABLE mart_waimai.view2create_non_encrypt_columns;

SHOW TABLES;
DROP TABLE mart_waimai.tbl2create;
DROP VIEW mart_waimai.view2create_star;
DROP VIEW mart_waimai.view2create_non_encrypt_columns;
DROP VIEW mart_waimai.view2create_encrypt_columns;
