val test_sql="DROP DATABASE IF EXISTS testdb CASCADE";
spark.sql(test_sql).collect().foreach(println);

val test_sql="CREATE DATABASE testdb WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02')";
spark.sql(test_sql).collect().foreach(println);

--testAccessNoPrivilegeDB.sql
val test_sql="DROP DATABASE IF EXISTS unaccessibledb CASCADE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE unaccessibledb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data";
spark.sql(test_sql).collect().foreach(println);

--testAddFile.sql
val test_sql="CREATE TABLE testdb.tbl4addfile(who string)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/who.txt' OVERWRITE INTO TABLE testdb.tble4addfile";
spark.sql(test_sql).collect().foreach(println);

--testAddJarCreateFuncAndTmpFunc.sql
val test_sql="CREATE TABLE testdb.tbl4jarfile (name STRING)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="INSERT INTO testdb.tbl4jarfile VALUES ('TEACHER QA')";
spark.sql(test_sql).collect().foreach(println);

--testAddRenameDropShowPartition.sql
val test_sql="CREATE TABLE testdb.tbl4partition (id INT, part STRING, quantity INT)  PARTITIONED BY (day INT)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.tbl4partition ADD PARTITION (day=20110102)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.tbl4partition ADD PARTITION (day=20110103)";
spark.sql(test_sql).collect().foreach(println);

--testAlterDescribeTableSetLocation.sql
--testAlterDescribeTableSetLocationPartition.sql
val test_sql="""CREATE TABLE testdb.tbl4setlocation (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'""";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.tbl4setlocation ADD PARTITION (year = 2011, month = 1, day = 1)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.tbl4setlocation ADD PARTITION (year = 2011, month = 1, day = 2)";
spark.sql(test_sql).collect().foreach(println);

--testAlterSerDePartition.sql
val test_sql="""CREATE TABLE testdb.test_serde_partition (c0 string, c1 string, c2 string) PARTITIONED BY (col10 STRING, col20 STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES ('input.regex' = 'bduid\\[(.*)\\]uid\\[(\\d+)\\]uname\\[(.*)\\]', 'output.format.string' = '%1$s\t%2$s') STORED AS TEXTFILE""";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.test_serde_partition ADD PARTITION (col10='abc', col20='123')";
spark.sql(test_sql).collect().foreach(println);

--testAlterSerDeTable.scala
val test_sql="CREATE TABLE testdb.test_serde (c0 string, c1 string, c2 string) ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES ('input.regex' = 'bduid\\[(.*)\\]uid\\[(\\d+)\\]uname\\[(.*)\\]', 'output.format.string' = '%1$s\t%2$s') STORED AS TEXTFILE";
spark.sql(test_sql).collect().foreach(println);

--testAlterTableAddColumns.scala
val test_sql="CREATE TABLE testdb.tbl4addcolumns (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP)";
spark.sql(test_sql).collect().foreach(println);

--testAlterTableChange.sql
val test_sql="CREATE TABLE testdb.tbl4change (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP)";
spark.sql(test_sql).collect().foreach(println);

--testAlterTableAddPartitionLocation.sql
--testAlterTableSetFileformat.sql
val test_sql="""CREATE TABLE testdb.tbl4fileformat (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""CREATE EXTERNAL TABLE testdb.tbl4fileformat_external (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb.tbl4fileformat ADD PARTITION (year=2012, month=1, day=1)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.tbl4fileformat_external ADD PARTITION (year=2012, month=1, day=1)";
spark.sql(test_sql).collect().foreach(println);

--testAlterTableEnableDisable.sql
val test_sql="""CREATE TABLE testdb.test_enable_disable1 (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""CREATE TABLE testdb.test_enable_disable2 (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'""";
spark.sql(test_sql).collect().foreach(println);

--testAlterTableEnableDisablePartition.sql
val test_sql="""CREATE TABLE testdb.test_enable_disable_partition (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb.test_enable_disable_partition ADD PARTITION (year = 2017, month = 8, day = 1)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.test_enable_disable_partition ADD PARTITION (year = 2017, month = 8, day = 2)";
spark.sql(test_sql).collect().foreach(println);

--testAlterTableRename.sql
val test_sql="CREATE TABLE testdb.tbl4rename (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP)";
spark.sql(test_sql).collect().foreach(println);

--testAlterTableReplaceColumns.sql
val test_sql="CREATE TABLE testdb.tbl4replacecolumns (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP)";
spark.sql(test_sql).collect().foreach(println);

--testAlterTableTouch.sql
--testAlterTableTouchPartition.sql
--testAlterTableClusteredBySortedBy.sql
--testTableAnalyze.sql
val test_sql="""CREATE TABLE testdb.tbl4analyze (
 name STRING
,salary FLOAT
,subordinates ARRAY<STRING>
,deductions MAP<STRING, FLOAT>
,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb.tbl4analyze ADD PARTITION (country = 'US', state = 'CA')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.tbl4analyze ADD PARTITION (country = 'US', state = 'OR')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.tbl4analyze ADD PARTITION (country = 'US', state = 'IL')";
spark.sql(test_sql).collect().foreach(println);


--testCreateAlterDropTableView.sql
val test_sql="CREATE TABLE testdb.tbl4drop (col1 TINYINT, col2 SMALLINT)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE VIEW testdb.view4drop AS SELECT col1, col2 FROM testdb.tbl4drop";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE TABLE testdb.tbl4drop_no_r (col1 TINYINT, col2 SMALLINT)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE VIEW testdb.view4drop_no_r AS SELECT col1, col2 FROM testdb.tbl4drop_no_r";
spark.sql(test_sql).collect().foreach(println);

--testCreateDB.sql
val test_sql="DROP DATABASE IF EXISTS db4create CASCADE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP DATABASE IF EXISTS db4create_no_privilege CASCADE";
spark.sql(test_sql).collect().foreach(println);

--testDropDB.sql
val test_sql="DROP DATABASE IF EXISTS db4drop CASCADE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP DATABASE IF EXISTS db4drop_cascade CASCADE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE db4drop WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE db4drop_cascade WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE TABLE db4drop_cascade.tbl4drop (col1 TINYINT, col2 SMALLINT)";
spark.sql(test_sql).collect().foreach(println);

--testImportExportPartition.sql
val test_sql="""CREATE TABLE testdb.import_export (
 name STRING
,salary FLOAT
,subordinates ARRAY<STRING>
,deductions MAP<STRING, FLOAT>
,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""CREATE TABLE testdb.src_import_export (
 name STRING
,salary FLOAT
,subordinates ARRAY<STRING>
,deductions MAP<STRING, FLOAT>
,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb.src_import_export ADD PARTITION (country = 'US', state = 'CA')";
spark.sql(test_sql).collect().foreach(println);

val test_sql="LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE testdb.src_import_export
PARTITION (country = 'US', state = 'CA')";
spark.sql(test_sql).collect().foreach(println);

--testInsertIntoFromQuery.sql
val test_sql="CREATE TABLE testdb.sessionization_step_one_origins (
  ssoo_user_id STRING
 ,ssoo_pageview_id STRING
 ,ssoo_timestamp DOUBLE)";
spark.sql(test_sql).collect().foreach(println);

val test_sql='''CREATE TABLE testdb.session_test (
  st_user_id STRING
 ,st_pageview_id STRING
 ,st_page_url STRING
 ,st_referrer_url STRING
 ,st_timestamp DOUBLE)''';
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT INTO testdb.session_test VALUES ('100', '101', '102', 'HTTP://WWW.MEITUAN.COM', 10000)";
spark.sql(test_sql).collect().foreach(println);

--testInsertIntoTable.sql
--testInsertOverwriteTable.sql
val test_sql='CREATE TABLE testdb.src_insert_overwrite_tbl (name STRING, ip STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t"';
spark.sql(test_sql).collect().foreach(println);

val test_sql="CREATE TABLE testdb.insert_overwrite_tbl LIKE testdb.src_insert_overwrite_tbl";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT INTO testdb.insert_overwrite_tbl VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2')";
spark.sql(test_sql).collect().foreach(println);

--testInsertOverwriteDir.sql
val test_sql="""CREATE TABLE testdb.test_insert_overwrite_dir (
 name STRING
,salary FLOAT
,subordinates ARRAY<STRING>
,deductions MAP<STRING, FLOAT>
,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb.test_insert_overwrite_dir ADD PARTITION (country = 'US', state = 'CA')";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE testdb.test_insert_overwrite_dir
PARTITION (country = 'US', state = 'CA')""";
spark.sql(test_sql).collect().foreach(println);

--testInsertIntoTablePartition.sql
--testInsertOverwriteTablePartition.sql
--testInsertIntoTable.sql tetInsertOverwriteTable.sql-----------
val test_sql='''CREATE TABLE testdb.src_insert_overwrite_tbl_partition (name STRING, ip STRING)
PARTITIONED BY (dt STRING, ht STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t"''';
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb.src_insert_overwrite_tbl_partition ADD PARTITION (dt='20150617', ht='01')";
spark.sql(test_sql).collect().foreach(println);

val test_sql="CREATE TABLE testdb.insert_overwrite_tbl_partition LIKE testdb.src_insert_overwrite_tbl_partition";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT INTO testdb.src_insert_overwrite_tbl_partition PARTITION (dt='20150617', ht='00') VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2')";
spark.sql(test_sql).collect().foreach(println);

--testLoadDataLocalTable.sql
val test_sql="CREATE TABLE testdb.load_data_local_into_table (str STRING, countVal INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '&' LINES TERMINATED BY '10'";
spark.sql(test_sql).collect().foreach(println);

--testLoadDataLocalTablePartition.sql
val test_sql="""CREATE TABLE testdb.load_data_local_into_partition (
 name STRING
,salary FLOAT
,subordinates ARRAY<STRING>
,deductions MAP<STRING, FLOAT>
,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE""";
spark.sql(test_sql).collect().foreach(println);

--testMSCKRepairTable.sql
val test_sql="CREATE TABLE testdb.test_msck (id INT, val STRING) PARTITIONED BY(month INT)";
spark.sql(test_sql).collect().foreach(println);

--testQuery.sql
val test_sql="CREATE TABLE testdb.tbl4query (str STRING, countVal INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '&' LINES TERMINATED BY '10'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/test_file.txt' INTO TABLE testdb.tbl4query";
spark.sql(test_sql).collect().foreach(println);

--testShowColumnsAndTblProperties.sql
val test_sql="""CREATE TABLE testdb.employees_props (
  name  STRING COMMENT 'Employee name'
 ,salary  FLOAT  COMMENT'Employee salary'
 ,subordinates ARRAY<STRING> COMMENT 'Names of subordinates'
 ,deductions  MAP<STRING, FLOAT> COMMENT  'Keys are deductions names, values are percentages'
 ,address  STRUCT<street:STRING,city:STRING, state:STRING, zip:INT> COMMENT 'Home address')
COMMENT 'Description of the table'
PARTITIONED BY (country STRING, state STRING)
LOCATION '/user/hive/warehouse/testdb.db/employees_props'
TBLPROPERTIES ('creator'='HADOOP-QA','created_at'='2017-9-10 10:00:00', 'notes'='test show tblproperties')""";
spark.sql(test_sql).collect().foreach(println);

--testInsertOverwriteTablePartition02.sql
val test_sql="""CREATE TABLE testdb.test_insert_overwrite_tbl_partition (
 name STRING
,salary FLOAT
,subordinates ARRAY<STRING>
,deductions MAP<STRING, FLOAT>
,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""CREATE TABLE testdb.src_test_insert_overwrite_tbl_partition (
 name STRING
,salary FLOAT
,subordinates ARRAY<STRING>
,deductions MAP<STRING, FLOAT>
,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb.src_test_insert_overwrite_tbl_partition ADD PARTITION (country = 'US', state = 'CA')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.src_test_insert_overwrite_tbl_partition ADD PARTITION (country = 'US', state = 'OR')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.src_test_insert_overwrite_tbl_partition ADD PARTITION (country = 'US', state = 'IL')";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE testdb.src_test_insert_overwrite_tbl_partition
PARTITION (country = 'US', state = 'CA')""";
spark.sql(test_sql).collect().foreach(println);

:q
