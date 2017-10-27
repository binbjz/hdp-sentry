USE testdb;
ALTER TABLE tbl4rename SET TBLPROPERTIES ('notes' = 'Test for set tblproperties');
SHOW TBLPROPERTIES tbl4alter;
ALTER TABLE tbl4rename RENAME TO tbl4rename_new;

