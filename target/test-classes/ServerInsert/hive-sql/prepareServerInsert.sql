CREATE DATABASE db4drop WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
CREATE DATABASE db4alter WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
CREATE DATABASE test_db WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');

CREATE TABLE test_db.tbl4drop (col1 TINYINT);
CREATE VIEW test_db.view4drop AS SELECT * FROM test_db.tbl4drop;
CREATE DATABASE test_db WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
CREATE TABLE test_db.tbl4alter (col1 TINYINT, col2 INT);

CREATE TABLE IF NOT EXISTS test_db.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

CREATE EXTERNAL TABLE IF NOT EXISTS test_db.log_messages_external (hms INT, severity STRING, server STRING, process_id INT, message STRING) PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
ALTER TABLE test_db.log_messages ADD PARTITION(year = 2012, month = 1, day = 1);

CREATE TABLE IF NOT EXISTS test_db.log_messages02 (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
ALTER TABLE test_db.log_messages02 ADD PARTITION (year = 2011, month = 1, day = 1);

CREATE TABLE IF NOT EXISTS test_db.test_enable_disable (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

CREATE TABLE test_db.supply (id INT, part STRING, quantity INT)  PARTITIONED BY (day INT);
ALTER TABLE test_db.supply ADD PARTITION (day = 20110102);
ALTER TABLE test_db.supply ADD PARTITION (day = 20110103);

CREATE TABLE test_db.collecttest (str STRING, countVal INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '&' LINES TERMINATED BY '10';

CREATE TABLE test_db.session_test (
  st_user_id STRING
 ,st_pageview_id STRING
 ,st_page_url STRING
 ,st_referrer_url STRING
 ,st_timestamp DOUBLE);

CREATE TABLE test_db.sessionization_step_one_origins (
  st_user_id STRING
 ,st_pageview_id STRING
 ,st_timestamp DOUBLE);

CREATE TABLE test_db.partition_table001 (name STRING, ip STRING)
PARTITIONED BY (dt STRING, ht STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";

CREATE TABLE IF NOT EXISTS test_db.partition_table002 LIKE test_db.partition_table001;

CREATE TABLE test_db.table001 (name STRING, ip STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";

CREATE TABLE IF NOT EXISTS test_db.table002 LIKE test_db.table001;

CREATE TABLE test_db.teacher (name STRING);

CREATE TABLE test_db.whoyouare(who string);

CREATE TABLE test_db.test_serde (c0 string, c1 string, c2 string) ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES ('input.regex' = 'bduid\\[(.*)\\]uid\\[(\\d+)\\]uname\\[(.*)\\]', 'output.format.string' = '%1$s\t%2$s') STORED AS TEXTFILE;

CREATE TABLE test_db.test_serde_partition(c0 string, c1 string, c2 string) PARTITIONED BY (col10 STRING, col20 STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES ('input.regex' = 'bduid\\[(.*)\\]uid\\[(\\d+)\\]uname\\[(.*)\\]', 'output.format.string' = '%1$s\t%2$s') STORED AS TEXTFILE;
ALTER TABLE test_db.test_serde_partition ADD PARTITION (col10='abc', col20='123');

CREATE TABLE test_db.staged_employees (
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

CREATE TABLE test_db.employees (
 name STRING
,salary FLOAT
,subordinates ARRAY<STRING>
,deductions MAP<STRING, FLOAT>
,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;

CREATE TABLE test_db.employees02 (
  name STRING
 ,salary FLOAT
 ,subordinates ARRAY<STRING>
 ,deductions MAP<STRING, FLOAT>
 ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
COLLECTIONS ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;

CREATE TABLE test_db.staged_employees02 (
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

CREATE TABLE IF NOT EXISTS test_db.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

CREATE TABLE IF NOT EXISTS test_db.employees_props (
name  STRING COMMENT 'Employee name'
,salary  FLOAT  COMMENT'Employee salary'
,subordinates ARRAY<STRING> COMMENT 'Names of subordinates'
,deductions  MAP<STRING, FLOAT> COMMENT  'Keys are deductions names, values are percentages'
,address  STRUCT<street:STRING,city:STRING, state:STRING, zip:INT> COMMENT 'Home address')
COMMENT 'Description of the table'
PARTITIONED BY (country STRING, state STRING)
LOCATION '/user/hive/warehouse/test_db.db/employees_props'
TBLPROPERTIES ('creator'='HADOOP-QA','created_at'='2017-9-10 10:00:00', 'notes'='test show tblproperties');

CREATE TABLE IF NOT EXISTS db4alter.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
ALTER TABLE db4alter.log_messages ADD PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE db4alter.log_messages ADD PARTITION (year = 2017, month = 8, day = 2);
ALTER TABLE db4alter.log_messages PARTITION (year = 2017, month = 8, day = 2) ENABLE NO_DROP;
CREATE DATABASE db4msck;
CREATE TABLE db4msck.test_msck (id INT, val STRING) PARTITIONED BY(month INT);
