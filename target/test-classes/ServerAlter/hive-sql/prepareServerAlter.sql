CREATE TABLE IF NOT EXISTS tbl4show (
 name  STRING COMMENT 'Employee name'
,salary  FLOAT  COMMENT'Employee salary'
,subordinates ARRAY<STRING> COMMENT 'Names of subordinates'
,deductions  MAP<STRING, FLOAT> COMMENT  'Keys are deductions names, values are percentages'
,address  STRUCT<street:STRING,city:STRING, state:STRING, zip:INT> COMMENT 'Home address')
COMMENT 'Description of the table'
PARTITIONED BY (country STRING, state STRING)
TBLPROPERTIES ('creator'='HADOOP-QA','created_at'='2017-9-10 10:00:00', 'notes'='test show tblproperties');
CREATE VIEW view4show AS SELECT name, salary, subordinates FROM tbl4show;
CREATE DATABASE db4show WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
