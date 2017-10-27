--DROP DATABASE IF EXISTS db4properties CASCADE;
--CREATE TABLE IF NOT EXISTS db4properties.employees_props (
--  name  STRING COMMENT 'Employee name'
-- ,salary  FLOAT  COMMENT'Employee salary'
-- ,subordinates ARRAY<STRING> COMMENT 'Names of subordinates'
-- ,deductions  MAP<STRING, FLOAT> COMMENT  'Keys are deductions names, values are percentages'
-- ,address  STRUCT<street:STRING,city:STRING, state:STRING, zip:INT> COMMENT 'Home address')
-- COMMENT 'Description of the table'
--PARTITIONED BY (country STRING, state STRING)
--LOCATION '/user/hive/warehouse/db4properties.db/employees_props'
--TBLPROPERTIES ('creator'='HADOOP-QA','created_at'='2017-9-10 10:00:00', 'notes'='test show tblproperties');
--CREATE DATABASE db4properties;

--DROP TABLE db4properties.employees_props;
--DROP DATABASE db4properties;

USE db4properties;

SHOW TBLPROPERTIES employees_props;
SHOW COLUMNS IN db4properties.employees_props;
SHOW COLUMNS FROM db4properties.employees_props;
