SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
CREATE TABLE testdb.tbl4query (str STRING, countVal INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '&' LINES TERMINATED BY '10';
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/test_file.txt' INTO TABLE testdb.tbl4query;


CREATE DATABASE unaccessibledb;
CREATE DATABASE db4drop WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
CREATE DATABASE db2drop WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
CREATE DATABASE db4drop_cascade WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
CREATE TABLE db4drop_cascade.test_tbl (col1 TINYINT, col2 SMALLINT);
CREATE VIEW db4drop_cascade.test_view AS SELECT col1, col2 FROM db4drop_cascade.test_tbl;
CREATE DATABASE db4tbl WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
CREATE TABLE db4tbl.tbl4show (col1 TINYINT, col2 SMALLINT);
CREATE VIEW db4tbl.view4show AS SELECT col1, col2 FROM db4tbl.tbl4show;
CREATE DATABASE db4alter WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
CREATE DATABASE testdb;


CREATE TABLE testdb.src_employees_analyze (
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

ALTER TABLE testdb.src_employees_analyze ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE testdb.src_employees_analyze ADD PARTITION (country = 'US', state = 'OR');
ALTER TABLE testdb.src_employees_analyze ADD PARTITION (country = 'US', state = 'IL');

CREATE TABLE testdb.partition_table001 (name STRING, ip STRING)
PARTITIONED BY (dt STRING, ht STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";
CREATE TABLE IF NOT EXISTS testdb.partition_table002 LIKE testdb.partition_table001;

CREATE TABLE IF NOT EXISTS testdb.employees_props (
  name  STRING COMMENT 'Employee name'
 ,salary  FLOAT  COMMENT'Employee salary'
 ,subordinates ARRAY<STRING> COMMENT 'Names of subordinates'
 ,deductions  MAP<STRING, FLOAT> COMMENT  'Keys are deductions names, values are percentages'
 ,address  STRUCT<street:STRING,city:STRING, state:STRING, zip:INT> COMMENT 'Home address')
COMMENT 'Description of the table'
PARTITIONED BY (country STRING, state STRING)
LOCATION '/user/hive/warehouse/testdb.db/employees_props'
TBLPROPERTIES ('creator'='HADOOP-QA','created_at'='2017-9-10 10:00:00', 'notes'='test show tblproperties');

CREATE TABLE testdb.test_msck (id INT, val STRING) PARTITIONED BY(month INT);

CREATE TABLE testdb.collecttest (str STRING, countval INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '&' LINES TERMINATED BY '10';

CREATE TABLE testdb.test_insert_overwrite_dir (
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

ALTER TABLE testdb.test_insert_overwrite_dir ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE testdb.test_insert_overwrite_dir ADD PARTITION (country = 'US', state = 'OR');
ALTER TABLE testdb.test_insert_overwrite_dir ADD PARTITION (country = 'US', state = 'IL');


CREATE TABLE testdb.tbl4partition (id INT, part STRING, quantity INT)  PARTITIONED BY (day INT);

CREATE TABLE testdb.tbl4addfile(who string);
SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/who.txt' OVERWRITE INTO TABLE testdb.tble4addfile;

CREATE TABLE testdb.tbl4addjar (name STRING);
INSERT INTO testdb.tbl4addjar VALUES ('TEACHER QA');

CREATE TABLE testdb.session_test (
  st_user_id STRING
 ,st_pageview_id STRING
 ,st_page_url STRING
 ,st_referrer_url STRING
 ,st_timestamp DOUBLE);

CREATE TABLE testdb.tbl4addcolumns (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);
CREATE TABLE testdb.tbl4change (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);
CREATE TABLE testdb.tbl4replacecolumns (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);
CREATE TABLE testdb.tbl4rename (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);

CREATE TABLE IF NOT EXISTS testdb.test_enable_disable_partition (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE testdb.test_enable_disable_partition ADD PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE testdb.test_enable_disable_partition ADD PARTITION (year = 2017, month = 8, day = 2);

CREATE TABLE IF NOT EXISTS testdb.test_enable_disable1 (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

CREATE TABLE IF NOT EXISTS testdb.test_enable_disable2 (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';



CREATE TABLE testdb.table001 (name STRING, ip STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";
CREATE TABLE IF NOT EXISTS testdb.table002 LIKE testdb.table001;

CREATE TABLE testdb.src_employees (
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

CREATE TABLE testdb.employees (
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

CREATE TABLE testdb.test_serde (c0 string, c1 string, c2 string) ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES ('input.regex' = 'bduid\\[(.*)\\]uid\\[(\\d+)\\]uname\\[(.*)\\]', 'output.format.string' = '%1$s\t%2$s') STORED AS TEXTFILE;

CREATE TABLE testdb.test_serde_partition (c0 string, c1 string, c2 string) PARTITIONED BY (col10 STRING, col20 STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES ('input.regex' = 'bduid\\[(.*)\\]uid\\[(\\d+)\\]uname\\[(.*)\\]', 'output.format.string' = '%1$s\t%2$s') STORED AS TEXTFILE;
ALTER TABLE testdb.test_serde_partition ADD PARTITION (col10='abc', col20='123');

CREATE TABLE IF NOT EXISTS testdb.tbl4setlocation (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
ALTER TABLE testdb.tbl4setlocation ADD PARTITION (year = 2011, month = 1, day = 1);
ALTER TABLE testdb.tbl4setlocation ADD PARTITION (year = 2011, month = 1, day = 2);

CREATE TABLE IF NOT EXISTS db4alter.tbl4fileformat (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

CREATE EXTERNAL TABLE IF NOT EXISTS db4alter.tbl4fileformat_external (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';


CREATE TABLE testdb.import_export (
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

CREATE TABLE testdb.src_import_export (
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

ALTER TABLE testdb.src_import_export ADD PARTITION (country = 'US', state = 'CA');
