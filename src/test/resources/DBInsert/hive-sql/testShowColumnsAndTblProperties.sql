--Precondition:
CREATE DATABASE test_db2;
USE test_DB2;
CREATE TABLE IF NOT EXISTS employees_props (
  name  STRING COMMENT 'Employee name'
 ,salary  FLOAT  COMMENT'Employee salary'
 ,subordinates ARRAY<STRING> COMMENT 'Names of subordinates'
 ,deductions  MAP<STRING, FLOAT> COMMENT  'Keys are deductions names, values are percentages'
 ,address  STRUCT<street:STRING,city:STRING, state:STRING, zip:INT> COMMENT 'Home address')
COMMENT 'Description of the table'
PARTITIONED BY (country STRING, state STRING)
LOCATION '/user/hive/warehouse/test_db2.db/employees_props'
TBLPROPERTIES ('creator'='HADOOP-QA','created_at'='2017-9-10 10:00:00', 'notes'='test show tblproperties');

--Execution
SHOW TBLPROPERTIES test_db2.employees_props;
SHOW COLUMNS IN test_db2.employees_props;
SHOW COLUMNS FROM test_db2.employees_props;

--Cleanup:
DROP TABLE test_db2.employees_props;
DROP DATABASE test_db2;