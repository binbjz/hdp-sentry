USE mart_waimai;

ALTER TABLE test_rename RENAME TO test_rename_new;
ALTER TABLE test_rename_new RENAME TO test_rename;

USE dim;

ALTER TABLE ndm_user RENAME TO ndm_user_new;
ALTER TABLE ndm_user_new RENAME TO ndm_user;
