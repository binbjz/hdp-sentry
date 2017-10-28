USE testdb;

ALTER TABLE tbl4rename SET TBLPROPERTIES ('notes' = 'Test for set tblproperties');
SHOW TBLPROPERTIES tbl4rename;
ALTER TABLE tbl4rename RENAME TO tbl4rename_new;
SHOW TABLES LIKE 'tbl4rename*';
