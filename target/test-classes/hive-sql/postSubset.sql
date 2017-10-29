DROP DATABASE testdb CASCADE;

--testAccessNoPrivilegeDB.sql
DROP DATABASE unaccessibledb;

--testCreateAlterDropTableViewUnderDefaultDB.sql
DROP TABLE default.tbl4drop;
DROP VIEW default.view4drop;
DROP TABLE default.tbl4drop_no_r;
DROP VIEW default.view4drop_no_r;

--testCreateDB.sql
DROP DATABASE db4create;
DROP DATABASE db4create_no_privilege;

--testDropDB.sql
DROP DATABASE db4drop;
DROP DATABASE db4drop_cascade;
