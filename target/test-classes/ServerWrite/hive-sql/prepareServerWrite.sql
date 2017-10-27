----DB db4alter ----------------------------------
DROP DATABASE IF EXISTS db4alter CASCADE;
CREATE DATABASE db4alter WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');

CREATE TABLE db4alter.tbl4addcolumns (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);

CREATE TABLE db4alter.tbl4change (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);

CREATE TABLE db4alter.tbl4rename (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);

CREATE TABLE db4alter.tbl4replacecolumns (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);

CREATE TABLE IF NOT EXISTS db4alter.tbl4fileformat (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

CREATE EXTERNAL TABLE IF NOT EXISTS db4alter.tbl4fileformat_external (hms INT, severity STRING, server STRING, process_id INT, message STRING) PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

CREATE TABLE db4alter.employees (
  name STRING
 ,salary FLOAT
 ,subordinates ARRAY<STRING>
 ,deductions MAP<STRING, FLOAT>
 ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;

CREATE TABLE db4alter.src_employees (
  name STRING
 ,salary FLOAT
 ,subordinates ARRAY<STRING>
 ,deductions MAP<STRING, FLOAT>
 ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;

CREATE TABLE db4alter.test_serde_partition(c0 string, c1 string, c2 string) PARTITIONED BY (col10 STRING, col20 STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES ('input.regex' = 'bduid\\[(.*)\\]uid\\[(\\d+)\\]uname\\[(.*)\\]', 'output.format.string' = '%1$s\t%2$s') STORED AS TEXTFILE;

CREATE TABLE db4alter.test_serde (c0 string, c1 string, c2 string) ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES ('input.regex' = 'bduid\\[(.*)\\]uid\\[(\\d+)\\]uname\\[(.*)\\]', 'output.format.string' = '%1$s\t%2$s') STORED AS TEXTFILE;

----DB db4partition ----------------------------------
CREATE DATABASE db4partition;
CREATE TABLE IF NOT EXISTS db4partition.test_enable_disable_partition (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

----DB db2alter ----------------------------------
DROP DATABASE IF EXISTS db2alter CASCADE;
CREATE DATABASE db2alter WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');

----DB db4enable ----------------------------------
DROP DATABASE IF EXISTS db4enable CASCADE;
CREATE DATABASE db4enable;
CREATE TABLE IF NOT EXISTS db4enable.test_enable_disable (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

----DB db4view ----------------------------------
DROP DATABASE IF EXISTS db4view CASCADE;
CREATE DATABASE db4view WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
CREATE TABLE db4view.tbl4view (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);

----DB db4drop_cascade ----------------------------------
DROP DATABASE IF EXISTS db4drop_cascade CASCADE;

----DB db4create ----------------------------------
DROP DATABASE IF EXISTS db4create CASCADE;

----DB testdb ----------------------------------
DROP DATABASE IF EXISTS testdb CASCADE;
CREATE DATABASE testdb WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
CREATE TABLE testdb.collecttest (str STRING, countVal INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '&' LINES TERMINATED BY '10';

----DB db4data ----------------------------------
DROP DATABASE IF EXISTS db4data CASCADE;
CREATE DATABASE db4data;

CREATE TABLE db4data.session_test (
   st_user_id STRING
  ,st_pageview_id STRING
  ,st_page_url STRING
  ,st_referrer_url STRING
  ,st_timestamp DOUBLE);

CREATE TABLE db4data.src_employees_dir (
   name STRING
  ,salary FLOAT
  ,subordinates ARRAY<STRING>
  ,deductions MAP<STRING, FLOAT>
  ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;

CREATE TABLE db4data.table001 (name STRING, ip STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";
CREATE TABLE IF NOT EXISTS db4data.table002 LIKE db4data.table001;


DROP DATABASE IF EXISTS db4partition CASCADE;
CREATE DATABASE db4partition;
CREATE TABLE db4partition.partition_table001 (name STRING, ip STRING)
PARTITIONED BY (dt STRING, ht STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";
CREATE TABLE IF NOT EXISTS db4partition.partition_table002 LIKE db4partition.partition_table001;


DROP DATABASE IF EXISTS db4data CASCADE;
CREATE DATABASE db4data;
CREATE TABLE db4data.src_employees (
   name STRING
  ,salary FLOAT
  ,subordinates ARRAY<STRING>
  ,deductions MAP<STRING, FLOAT>
  ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;

CREATE TABLE db4data.employees (
   name STRING
  ,salary FLOAT
  ,subordinates ARRAY<STRING>
  ,deductions MAP<STRING, FLOAT>
  ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;

----DB db4msck ----------------------------------
DROP DATABASE IF EXISTS db4msck CASCADE;
CREATE TABLE db4msck.test_msck (id INT, val STRING) PARTITIONED BY(month INT);
CREATE DATABASE db4msck;

----DB db4properties ----------------------------------
DROP DATABASE IF EXISTS db4properties CASCADE;
CREATE TABLE IF NOT EXISTS db4properties.employees_props (
  name  STRING COMMENT 'Employee name'
 ,salary  FLOAT  COMMENT'Employee salary'
 ,subordinates ARRAY<STRING> COMMENT 'Names of subordinates'
 ,deductions  MAP<STRING, FLOAT> COMMENT  'Keys are deductions names, values are percentages'
 ,address  STRUCT<street:STRING,city:STRING, state:STRING, zip:INT> COMMENT 'Home address')
 COMMENT 'Description of the table'
PARTITIONED BY (country STRING, state STRING)
LOCATION '/user/hive/warehouse/db4properties.db/employees_props'
TBLPROPERTIES ('creator'='HADOOP-QA','created_at'='2017-9-10 10:00:00', 'notes'='test show tblproperties');
CREATE DATABASE db4properties;


DROP DATABASE IF EXISTS db4data CASCADE;
CREATE DATABASE db4data;
CREATE TABLE db4data.src_employees_analyze (
   name STRING
  ,salary FLOAT
  ,subordinates ARRAY<STRING>
  ,deductions MAP<STRING, FLOAT>
  ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;

----DB tbl4setlocation ----------------------------------
DROP DATABASE IF EXISTS tbl4setlocation CASCADE;
CREATE DATABASE tbl4setlocation;
CREATE TABLE IF NOT EXISTS db4alter.tbl4setlocation (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';


----DB db4partition ----------------------------------
DROP DATABASE IF EXISTS db4partition CASCADE;
CREATE DATABASE db4partition;
CREATE TABLE db4partition.tbl4partition (id INT, part STRING, quantity INT) PARTITIONED BY (day INT);

----DB db4add ----------------------------------
DROP DATABASE IF EXISTS db4add CASCADE;
CREATE DATABASE db4add;
CREATE TABLE db4add.tbl4addfile(who STRING);

----DB db4func ----------------------------------
DROP DATABASE IF EXISTS db4func CASCADE;
CREATE DATABASE db4func;
CREATE TABLE db4func.tbl4func (name STRING);
