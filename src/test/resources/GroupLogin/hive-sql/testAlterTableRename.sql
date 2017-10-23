USE mart_waimai;
CREATE TABLE test_tbl (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);
ALTER TABLE test_tbl RENAME TO test_tbl_new;
ALTER TABLE test_tbl_new SET TBLPROPERTIES ('notes' = 'Test for set tblproperties');
SHOW TBLPROPERTIES test_tbl_new;
DROP TABLE test_tbl_new;

USE dim;
ALTER TABLE ndm_user RENAME TO ndm_user_new;
ALTER TABLE ndm_user_new SET TBLPROPERTIES ('notes' = 'Test for set tblproperties');
SHOW TBLPROPERTIES ndm_user_new;
ALTER TABLE ndm_user_new RENAME TO ndm_user;
