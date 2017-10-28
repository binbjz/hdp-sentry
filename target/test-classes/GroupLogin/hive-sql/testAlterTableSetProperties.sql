USE mart_waimai;

ALTER TABLE test_rename SET TBLPROPERTIES ('notes' = 'Test for set tblproperties');
SHOW TBLPROPERTIES test_rename;

USE dim;

ALTER TABLE ndm_user SET TBLPROPERTIES ('notes' = 'Test for set tblproperties');
SHOW TBLPROPERTIES ndm_user;
