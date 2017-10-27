CREATE DATABASE unaccessdb WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');

CREATE DATABASE db4drop_cascade WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
CREATE TABLE db4drop_cascade.tbl4drop (col1 TINYINT, col2 SMALLINT);

CREATE DATABASE testdb WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
CREATE TABLE testdb.tbl4drop (col1 TINYINT, col2 SMALLINT);
CREATE VIEW testdb.view4drop AS SELECT col1, col2 FROM testdb.tbl4drop;
CREATE TABLE testdb.tbl4drop_no_r (col1 TINYINT, col2 SMALLINT);
CREATE VIEW testdb.view4drop_no_r AS SELECT col1, col2 FROM testdb.tbl4drop_no_r;

CREATE TABLE testdb.tbl4addcolumns (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);
CREATE TABLE testdb.tbl4change (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);
CREATE TABLE testdb.tbl4rename (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);
CREATE TABLE testdb.tbl4replacecolumns (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);

CREATE TABLE IF NOT EXISTS testdb.log_messages2 (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';


CREATE TABLE IF NOT EXISTS testdb.tbl4fileformat (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
CREATE EXTERNAL TABLE IF NOT EXISTS testdb.tbl4fileformat_external (hms INT, severity STRING, server STRING, process_id INT, message STRING) PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';


ALTER TABLE testdb.tbl4fileformat ADD PARTITION (year = 2012, month = 1, day = 1) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb.db/tbl4fileformat/2012/01/02';
ALTER TABLE testdb.tbl4fileformat_external ADD PARTITION (year = 2012, month = 1, day = 2) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb.db/tbl4fileformat_external/2012/01/02';

ALTER TABLE testdb.log_messages2 ADD PARTITION (year = 2011, month = 1, day = 1);
ALTER TABLE testdb.log_messages2 ADD PARTITION (year = 2011, month = 1, day = 2);

CREATE TABLE testdb.tbl4partition (id INT, part STRING, quantity INT)  PARTITIONED BY (day INT);
ALTER TABLE testdb.tbl4partition ADD PARTITION (day = 20110102);
ALTER TABLE testdb.tbl4partition ADD PARTITION (day = 20110103);

CREATE TABLE testdb.collecttest (str STRING, countVal INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '&' LINES TERMINATED BY '10';

CREATE TABLE testdb.session_test (
  st_user_id STRING
 ,st_pageview_id STRING
 ,st_page_url STRING
 ,st_referrer_url STRING
 ,st_timestamp DOUBLE);

CREATE TABLE testdb.sessionization_step_one_origins (
  ssoo_user_id STRING
 ,ssoo_pageview_id STRING
 ,ssoo_timestamp DOUBLE);

CREATE TABLE testdb.partition_table001 (name STRING, ip STRING)
PARTITIONED BY (dt STRING, ht STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";
CREATE TABLE IF NOT EXISTS testdb.partition_table002 LIKE testdb.partition_table001;

CREATE TABLE testdb.table001 (name STRING, ip STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";
CREATE TABLE IF NOT EXISTS testdb.table002 LIKE testdb.table001;

CREATE TABLE testdb.tbl4jarfile (name STRING);
INSERT INTO testdb.tbl4jarfile VALUES ('TEACHER QA');

CREATE TABLE testdb.tbl4addfile(who string);

CREATE TABLE testdb.test_serde (c0 string, c1 string, c2 string) ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES ('input.regex' = 'bduid\\[(.*)\\]uid\\[(\\d+)\\]uname\\[(.*)\\]', 'output.format.string' = '%1$s\t%2$s') STORED AS TEXTFILE;

CREATE TABLE testdb.test_partition_serde(c0 string, c1 string, c2 string) PARTITIONED BY (col10 STRING, col20 STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES ('input.regex' = 'bduid\\[(.*)\\]uid\\[(\\d+)\\]uname\\[(.*)\\]', 'output.format.string' = '%1$s\t%2$s') STORED AS TEXTFILE;

ALTER TABLE testdb.test_partition_serde ADD PARTITION (col10='abc', col20='123');

CREATE TABLE testdb.src_employees_dir (
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

CREATE TABLE testdb.import_export2 (
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
ALTER TABLE testdb.import_export ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE testdb.import_export ADD PARTITION (country = 'CHN', state = 'BJ') ;


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

CREATE TABLE IF NOT EXISTS testdb.test_enable_disable1 (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

CREATE TABLE IF NOT EXISTS testdb.test_enable_disable2 (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

CREATE TABLE IF NOT EXISTS testdb.test_enable_disable_partition (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE testdb.test_enable_disable_partition ADD PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE testdb.test_enable_disable_partition ADD PARTITION (year = 2017, month = 8, day = 2);

CREATE TABLE testdb.test_msck (id INT, val STRING) PARTITIONED BY(month INT);

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

ALTER TABLE testdb.src_employees ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE testdb.src_employees ADD PARTITION (country = 'US', state = 'OR');
ALTER TABLE testdb.src_employees ADD PARTITION (country = 'US', state = 'IL');

ALTER TABLE testdb.employees ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE testdb.employees ADD PARTITION (country = 'US', state = 'OR');
ALTER TABLE testdb.employees ADD PARTITION (country = 'US', state = 'IL');

INSERT INTO testdb.partition_table001 PARTITION (dt='20150617', ht='00') VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2'), ('alibaba', '10.0.0.3');

