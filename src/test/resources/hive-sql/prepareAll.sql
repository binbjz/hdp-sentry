SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;

DROP DATABASE IF EXISTS testdb CASCADE;
CREATE DATABASE testdb WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');

--testAccessNoPrivilegeDB.sql
DROP DATABASE IF EXISTS unaccessibledb CASCADE;
CREATE DATABASES unaccessibledb;

USE testdb;
--testAddFile.sql
CREATE TABLE testdb.tbl4addfile(who string);
SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/who.txt' OVERWRITE INTO TABLE testdb.tble4addfile;

--testAddJarCreateFuncAndTmpFunc.sql
CREATE TABLE testdb.tbl4jarfile (name STRING);
INSERT INTO testdb.tbl4jarfile VALUES ('TEACHER QA');

--testAddRenameDropShowPartition.sql
CREATE TABLE testdb.tbl4partition (id INT, part STRING, quantity INT)  PARTITIONED BY (day INT);

--testAlterDescribeTableSetLocation.sql
--testAlterDescribeTableSetLocationPartition.sql
CREATE TABLE testdb.tbl4setlocation (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
ALTER TABLE testdb.tbl4setlocation ADD PARTITION (year = 2011, month = 1, day = 1);
ALTER TABLE testdb.tbl4setlocation ADD PARTITION (year = 2011, month = 1, day = 2);

--testAlterSerDePartition.sql
CREATE TABLE testdb.test_serde_partition (c0 string, c1 string, c2 string) PARTITIONED BY (col10 STRING, col20 STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES ('input.regex' = 'bduid\\[(.*)\\]uid\\[(\\d+)\\]uname\\[(.*)\\]', 'output.format.string' = '%1$s\t%2$s') STORED AS TEXTFILE;
ALTER TABLE testdb.test_serde_partition ADD PARTITION (col10='abc', col20='123');

--testAlterSerDeTable.sql
CREATE TABLE testdb.test_serde (c0 string, c1 string, c2 string) ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES ('input.regex' = 'bduid\\[(.*)\\]uid\\[(\\d+)\\]uname\\[(.*)\\]', 'output.format.string' = '%1$s\t%2$s') STORED AS TEXTFILE;




DROP TABLE testdb.tbl4addfile;
DROP TABLE testdb.tbl4jarfile;
DROP TABLE testdb.tbl4partition;
DROP TABLE testdb.tbl4setlocation;
DROP TABLE testdb.test_serde_partition;
DROP TABLE testdb.test_serde;
DROP TABLE testdb.tbl4addcolumns;
DROP TABLE testdb.tbl4change;
--DROP TABLE testdb.tbl4fileformat;
--DROP TABLE testdb.tbl4fileformat_external;
--DROP TABLE testdb.test_enable_disable_partition;
DROP TABLE testdb.test_enable_disable1;
DROP TABLE testdb.test_enable_disable2;
DROP DATABASE testdb CASCADE;
DROP DATABASE unaccessibledb CASCADE;



--testAlterTableAddColumns.sql
CREATE TABLE testdb.tbl4addcolumns (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);

--testAlterTableChange.sql
CREATE TABLE testdb.tbl4change (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);

--testAlterTableAddPartitionLocation.sql
--testAlterTableSetFileformat.sql
CREATE TABLE db4alter.tbl4fileformat (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

CREATE EXTERNAL TABLE db4alter.tbl4fileformat_external (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

--testAlterTableEnableDisable.sql
CREATE TABLE IF NOT EXISTS testdb.test_enable_disable1 (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

CREATE TABLE IF NOT EXISTS testdb.test_enable_disable2 (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

--testAlterTableEnableDisablePartition.sql
CREATE TABLE testdb.test_enable_disable_partition (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE testdb.test_enable_disable_partition ADD PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE testdb.test_enable_disable_partition ADD PARTITION (year = 2017, month = 8, day = 2);

--testAlterTableRename.sql
CREATE TABLE testdb.tbl4rename (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);

--testAlterTableReplaceColumns.sql
CREATE TABLE testdb.tbl4replacecolumns (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);

--testAlterTableTouch.sql
--testAlterTableTouchPartition.sql
--testAlterTableClusteredBySortedBy.sql
--testTableAnalyze.sql
CREATE TABLE testdb.tbl4analyze (
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

ALTER TABLE testdb.tbl4analyze ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE testdb.tbl4analyze ADD PARTITION (country = 'US', state = 'OR');
ALTER TABLE testdb.tbl4analyze ADD PARTITION (country = 'US', state = 'IL');

--testCreateAlterDropTableView.sql
CREATE TABLE testdb.tbl4drop (col1 TINYINT, col2 SMALLINT);
CREATE VIEW testdb.view4drop AS SELECT col1, col2 FROM testdb.tbl4drop;
CREATE TABLE testdb.tbl4drop_no_r (col1 TINYINT, col2 SMALLINT);
CREATE VIEW testdb.view4drop_no_r AS SELECT col1, col2 FROM testdb.tbl4drop_no_r;

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

--testImportExportPartition.sql
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

--testInsertIntoFromQuery.sql
CREATE TABLE testdb.sessionization_step_one_origins (
  ssoo_user_id STRING
 ,ssoo_pageview_id STRING
 ,ssoo_timestamp DOUBLE);

CREATE TABLE testdb.session_test (
  st_user_id STRING
 ,st_pageview_id STRING
 ,st_page_url STRING
 ,st_referrer_url STRING
 ,st_timestamp DOUBLE);

INSERT INTO testdb.session_test VALUES ('100', '101', '102', 'HTTP://WWW.MEITUAN.COM', 10000);

--testInsertIntoTable.sql
--testInsertOverwriteTable.sql
CREATE TABLE testdb.src_insert_overwrite_tbl (name STRING, ip STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";

CREATE TABLE testdb.insert_overwrite_tbl LIKE testdb.src_insert_overwrite_tbl;

INSERT INTO testdb.insert_overwrite_tbl VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2');

--testInsertOverwriteDir.sql
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

--testInsertIntoTablePartition.sql
--testInsertOverwriteTablePartition.sql
--testInsertIntoTable.sql tetInsertOverwriteTable.sql-----------
CREATE TABLE testdb.src_insert_overwrite_tbl_partition (name STRING, ip STRING)
PARTITIONED BY (dt STRING, ht STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";

CREATE TABLE testdb.insert_overwrite_tbl_partition LIKE testdb.src_insert_overwrite_tbl_partition;

INSERT INTO testdb.insert_overwrite_tbl_partition PARTITION (dt='20150617', ht='00') VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2');

--testLoadDataLocalTable.sql
CREATE TABLE testdb.load_data_local_into_table (str STRING, countVal INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '&' LINES TERMINATED BY '10';

--testLoadDataLocalTablePartition.sql
CREATE TABLE testdb.load_data_local_into_partition (
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

--testMSCKRepairTable.sql
CREATE TABLE testdb.test_msck (id INT, val STRING) PARTITIONED BY(month INT);

--testQuery.sql
CREATE TABLE testdb.tbl4query (str STRING, countVal INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '&' LINES TERMINATED BY '10';
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/test_file.txt' INTO TABLE testdb.tbl4query;

--testShowColumnsAndTblProperties.sql
CREATE TABLE testdb.employees_props (
  name  STRING COMMENT 'Employee name'
 ,salary  FLOAT  COMMENT'Employee salary'
 ,subordinates ARRAY<STRING> COMMENT 'Names of subordinates'
 ,deductions  MAP<STRING, FLOAT> COMMENT  'Keys are deductions names, values are percentages'
 ,address  STRUCT<street:STRING,city:STRING, state:STRING, zip:INT> COMMENT 'Home address')
COMMENT 'Description of the table'
PARTITIONED BY (country STRING, state STRING)
LOCATION '/user/hive/warehouse/testdb.db/employees_props'
TBLPROPERTIES ('creator'='HADOOP-QA','created_at'='2017-9-10 10:00:00', 'notes'='test show tblproperties');