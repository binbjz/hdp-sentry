DROP DATABASE IF EXISTS testdb CASCADE;
CREATE DATABASE testdb WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');

--testAccessNoPrivilegeDB.sql
DROP DATABASE IF EXISTS unaccessibledb CASCADE;
CREATE DATABASES unaccessibledb;

--testCreateAlterDropTableViewUnderDefaultDB.sql

CREATE TABLE default.tbl4drop (col1 TINYINT, col2 SMALLINT);
CREATE VIEW default.view4drop AS SELECT col1, col2 FROM default.tbl4drop;
CREATE TABLE default.tbl4drop_no_r (col1 TINYINT, col2 SMALLINT);
CREATE VIEW default.view4drop_no_r AS SELECT col1, col2 FROM default.tbl4drop_no_r;

--testCreateDB.sql
DROP DATABASE IF EXISTS db4create CASCADE;
DROP DATABASE IF EXISTS db4create_no_privilege CASCADE;

--testDropDB.sql
DROP DATABASE IF EXISTS db4drop CASCADE;
DROP DATABASE IF EXISTS db4drop_cascade CASCADE;
CREATE DATABASE db4drop WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
CREATE DATABASE db4drop_cascade WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
