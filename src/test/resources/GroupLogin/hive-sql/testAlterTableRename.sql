USE mart_waimai;
ALTER TABLE test_rename RENAME TO test_rename_new;
ALTER TABLE test_rename_new SET TBLPROPERTIES ('notes' = 'Test for set tblproperties');
SHOW TBLPROPERTIES test_rename_new;

USE dim;
ALTER TABLE ndm_user RENAME TO ndm_user_new;
ALTER TABLE ndm_user_new SET TBLPROPERTIES ('notes' = 'Test for set tblproperties');
SHOW TBLPROPERTIES ndm_user_new;
ALTER TABLE ndm_user_new RENAME TO ndm_user;
