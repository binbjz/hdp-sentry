USE encrypt_db4props;
CREATE TABLE IF NOT EXISTS employees_props (
  name  STRING COMMENT 'Employee name'
 ,salary  FLOAT  COMMENT'Employee salary'
 ,subordinates ARRAY<STRING> COMMENT 'Names of subordinates'
 ,deductions  MAP<STRING, FLOAT> COMMENT  'Keys are deductions names, values are percentages'
 ,address  STRUCT<street:STRING,city:STRING, state:STRING, zip:INT> COMMENT 'Home address')
COMMENT 'Description of the table'
PARTITIONED BY (country STRING, state STRING)
LOCATION '/user/hive/warehouse/encrypt_db4props.db/employees_props'
TBLPROPERTIES ('creator'='HADOOP-QA','created_at'='2017-9-10 10:00:00', 'notes'='test show tblproperties');

SHOW TBLPROPERTIES encrypt_db4props.employees_props;
SHOW COLUMNS IN encrypt_db4props.employees_props;
SHOW COLUMNS FROM encrypt_db4props.employees_props;

DROP TABLE encrypt_db4props.employees_props;
