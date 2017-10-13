USE default;

CREATE TABLE IF NOT EXISTS tbl4create (
 name  STRING COMMENT 'Employee name'
,salary  FLOAT  COMMENT'Employee salary'
,subordinates ARRAY<STRING> COMMENT 'Names of subordinates'
,deductions  MAP<STRING, FLOAT> COMMENT  'Keys are deductions names, values are percentages'
,address  STRUCT<street:STRING,city:STRING, state:STRING, zip:INT> COMMENT 'Home address')
COMMENT 'Description of the table'
PARTITIONED BY (country STRING, state STRING)
LOCATION '/user/hive/warehouse/tbl4create'
TBLPROPERTIES ('creator'='HADOOP-QA','created_at'='2017-9-10 10:00:00', 'notes'='test show tblproperties');
CREATE TABLE tbl4create2 (id STRING);
CREATE VIEW view2create AS SELECT * FROM tbl4show;
CREATE EXTERNAL TABLE IF NOT EXISTS log_messages_external (hms INT, severity STRING, server STRING, process_id INT, message STRING) PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

SHOW TABLES;

DROP TABLE tbl4create;
DROP TABLE tbl4create2;
DROP TABLE log_messages_external;
DROP TABLE tbl4show;
DROP VIEW view2create;
DROP VIEW view4show;
