val test_sql = "DROP DATABASE IF EXISTS test_login_db CASCADE";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "CREATE DATABASE test_login_db LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/test_login_db.db'";
spark.sql(test_sql).collect().foreach(println);

val test_sql = "DROP DATABASE IF EXISTS test_login_db_tbl CASCADE";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "CREATE DATABASE test_login_db_tbl LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/test_login_db_tbl.db'";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "CREATE TABLE test_login_db_tbl.test_tbl (name STRING ,salary FLOAT)";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "INSERT INTO test_login_db_tbl.test_tbl VALUES ('test login', 10)";
spark.sql(test_sql).collect().foreach(println);


val test_sql = "DROP DATABASE IF EXISTS testdb CASCADE";
spark.sql(test_sql).collect().foreach(println);

val test_sql = "CREATE DATABASE testdb LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb.db' WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02')";
spark.sql(test_sql).collect().foreach(println);

/*testAccessNoPrivilegeDB.scala*/

val test_sql = "DROP DATABASE IF EXISTS unaccessibledb CASCADE";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "CREATE DATABASE unaccessibledb LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/unaccessibledb.db'";
spark.sql(test_sql).collect().foreach(println);

val test_sql = "USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql = "SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/source-data";
spark.sql(test_sql).collect().foreach(println);

/*testAddFile.scala*/

val test_sql = "CREATE TABLE testdb.tbl4addfile(who string)";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/who.txt' OVERWRITE INTO TABLE testdb.tbl4addfile";
spark.sql(test_sql).collect().foreach(println);

/*testAddJarCreateFuncAndTmpFunc.scala*/

val test_sql = "CREATE TABLE testdb.tbl4jarfile (name STRING)";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "INSERT INTO testdb.tbl4jarfile VALUES ('TEACHER QA')";
spark.sql(test_sql).collect().foreach(println);

/*testAddRenameDropShowPartition.scala*/

val test_sql = "CREATE TABLE testdb.tbl4partition (id INT, part STRING, quantity INT)  PARTITIONED BY (day INT)";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "ALTER TABLE testdb.tbl4partition ADD PARTITION (day=20110102)";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "ALTER TABLE testdb.tbl4partition ADD PARTITION (day=20110103)";
spark.sql(test_sql).collect().foreach(println);

/*testAlterDescribeTableSetLocation.scala
  testAlterDescribeTableSetLocationPartition.scala*/

val test_sql =
  """CREATE TABLE testdb.tbl4setlocation (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'""";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "ALTER TABLE testdb.tbl4setlocation ADD PARTITION (year = 2011, month = 1, day = 1)";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "ALTER TABLE testdb.tbl4setlocation ADD PARTITION (year = 2011, month = 1, day = 2)";
spark.sql(test_sql).collect().foreach(println);

/*testAlterSerDePartitionAndTable.scala*/

val test_sql =
  """CREATE TABLE testdb.test_serde_partition (c0 string, c1 string, c2 string) PARTITIONED BY (col10 STRING, col20 STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES ('input.regex' = 'input_regex', 'output.format.string' = 'output_format_string') STORED AS TEXTFILE""";
spark.sql(test_sql).collect().foreach(println);

val test_sql = "ALTER TABLE testdb.test_serde_partition ADD PARTITION (col10='abc', col20='123')";
spark.sql(test_sql).collect().foreach(println);

/*testAlterSerDeTable.scala*/

val test_sql =
  """CREATE TABLE testdb.test_serde (c0 string, c1 string, c2 string) ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES ('input.regex' = 'bduid\\[(.*)\\]uid\\[(\\d+)\\]uname\\[(.*)\\]', 'output.format.string' = '%1$s\t%2$s') STORED AS TEXTFILE""";
spark.sql(test_sql).collect().foreach(println);

/*testAlterTableAddColumns.scala*/

val test_sql = "CREATE TABLE testdb.tbl4addcolumns (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP)";
spark.sql(test_sql).collect().foreach(println);

/*testAlterTableChange.scala*/

val test_sql = "CREATE TABLE testdb.tbl4change (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP)";
spark.sql(test_sql).collect().foreach(println);

/*testAlterTableAddPartitionLocation.scala
  testAlterTableSetFileformat.scala*/

val test_sql =
  """CREATE TABLE testdb.tbl4fileformat (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'""";
spark.sql(test_sql).collect().foreach(println);

val test_sql =
  """CREATE EXTERNAL TABLE testdb.tbl4fileformat_external (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb.db/tbl4fileformat_external'""";
spark.sql(test_sql).collect().foreach(println);


val test_sql = "ALTER TABLE testdb.tbl4fileformat ADD PARTITION (year=2012, month=1, day=1)";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "ALTER TABLE testdb.tbl4fileformat_external ADD PARTITION (year=2012, month=1, day=1)";
spark.sql(test_sql).collect().foreach(println);


/*testAlterTableEnableDisable.scala*/

val test_sql =
  """CREATE TABLE testdb.test_enable_disable1 (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'""";
spark.sql(test_sql).collect().foreach(println);

val test_sql =
  """CREATE TABLE testdb.test_enable_disable2 (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'""";
spark.sql(test_sql).collect().foreach(println);

/*testAlterTableEnableDisablePartition.scala*/

val test_sql =
  """CREATE TABLE testdb.test_enable_disable_partition (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'""";
spark.sql(test_sql).collect().foreach(println);

val test_sql = "ALTER TABLE testdb.test_enable_disable_partition ADD PARTITION (year = 2017, month = 8, day = 1)";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "ALTER TABLE testdb.test_enable_disable_partition ADD PARTITION (year = 2017, month = 8, day = 2)";
spark.sql(test_sql).collect().foreach(println);

/*testAlterTableRename.scala*/

val test_sql = "CREATE TABLE testdb.tbl4rename (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP)";
spark.sql(test_sql).collect().foreach(println);

/*testAlterTableReplaceColumns.scala*/

val test_sql = "CREATE TABLE testdb.tbl4replacecolumns (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP)";
spark.sql(test_sql).collect().foreach(println);

/*testAlterTableTouch.scala
  testAlterTableTouchPartition.scala
  testAlterTableClusteredBySortedBy.scala
  testTableAnalyze.scala*/

val test_sql =
  """CREATE TABLE testdb.tbl4analyze (
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

val test_sql = "ALTER TABLE testdb.tbl4analyze ADD PARTITION (country = 'US', state = 'CA')";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "ALTER TABLE testdb.tbl4analyze ADD PARTITION (country = 'US', state = 'OR')";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "ALTER TABLE testdb.tbl4analyze ADD PARTITION (country = 'US', state = 'IL')";
spark.sql(test_sql).collect().foreach(println);


/*testCreateAlterDropTableView.scala*/

val test_sql = "CREATE TABLE testdb.tbl4drop (col1 TINYINT, col2 SMALLINT)";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "CREATE VIEW testdb.view4drop AS SELECT col1, col2 FROM testdb.tbl4drop";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "CREATE TABLE testdb.tbl4drop_no_r (col1 TINYINT, col2 SMALLINT)";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "CREATE VIEW testdb.view4drop_no_r AS SELECT col1, col2 FROM testdb.tbl4drop_no_r";
spark.sql(test_sql).collect().foreach(println);

/*testCreateDB.scala*/

val test_sql = "DROP DATABASE IF EXISTS db4create CASCADE";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "DROP DATABASE IF EXISTS db4create_no_privilege CASCADE";
spark.sql(test_sql).collect().foreach(println);


/*testDropDB.scala*/

val test_sql = "DROP DATABASE IF EXISTS db4drop CASCADE";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "DROP DATABASE IF EXISTS db4drop_cascade CASCADE";
spark.sql(test_sql).collect().foreach(println);

val test_sql = "CREATE DATABASE db4drop LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/db4drop.db' WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02')";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "CREATE DATABASE db4drop_cascade LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/db4drop_cascade.db' WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02')";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "CREATE TABLE db4drop_cascade.tbl4drop (col1 TINYINT, col2 SMALLINT)";
spark.sql(test_sql).collect().foreach(println);


/*testImportExportPartition.scala*/




/*testInsertIntoFromQuery.scala*/

val test_sql =
  """CREATE TABLE testdb.sessionization_step_one_origins (
  ssoo_user_id STRING
 ,ssoo_pageview_id STRING
 ,ssoo_timestamp DOUBLE)""";
spark.sql(test_sql).collect().foreach(println);

val test_sql =
  """CREATE TABLE testdb.session_test (
  st_user_id STRING
 ,st_pageview_id STRING
 ,st_page_url STRING
 ,st_referrer_url STRING
 ,st_timestamp DOUBLE)""";
spark.sql(test_sql).collect().foreach(println);

val test_sql = "INSERT INTO testdb.session_test VALUES ('100', '101', '102', 'HTTP://WWW.MEITUAN.COM', 10000)";
spark.sql(test_sql).collect().foreach(println);


/*testInsertIntoTable.scala
  testInsertOverwriteTable.scala*/

val test_sql = "CREATE TABLE testdb.src_insert_overwrite_tbl (name STRING, ip STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'";
spark.sql(test_sql).collect().foreach(println);

val test_sql = "INSERT INTO testdb.src_insert_overwrite_tbl VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2')";
spark.sql(test_sql).collect().foreach(println);

val test_sql = "CREATE TABLE testdb.insert_overwrite_tbl LIKE testdb.src_insert_overwrite_tbl";
spark.sql(test_sql).collect().foreach(println);

val test_sql = "INSERT INTO testdb.insert_overwrite_tbl VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2')";
spark.sql(test_sql).collect().foreach(println);


/*testInsertOverwriteDir.scala*/

val test_sql =
  """CREATE TABLE testdb.test_insert_overwrite_dir (
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

val test_sql = "ALTER TABLE testdb.test_insert_overwrite_dir ADD PARTITION (country = 'US', state = 'CA')";
spark.sql(test_sql).collect().foreach(println);

val test_sql =
  """LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees2.csv'
INTO TABLE testdb.test_insert_overwrite_dir
PARTITION (country = 'US', state = 'CA')""";
spark.sql(test_sql).collect().foreach(println);


/*testInsertIntoTablePartition.scala
  testInsertOverwriteTablePartition.scala
  testInsertIntoTable.scala tetInsertOverwriteTable.scala*/

val test_sql =
  """CREATE TABLE testdb.src_insert_overwrite_tbl_partition (name STRING, ip STRING)
PARTITIONED BY (dt STRING, ht STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'""";
spark.sql(test_sql).collect().foreach(println);

val test_sql = "ALTER TABLE testdb.src_insert_overwrite_tbl_partition ADD PARTITION (dt='20150617', ht='01')";
spark.sql(test_sql).collect().foreach(println);

val test_sql = "CREATE TABLE testdb.insert_overwrite_tbl_partition LIKE testdb.src_insert_overwrite_tbl_partition";
spark.sql(test_sql).collect().foreach(println);

val test_sql = "INSERT INTO testdb.src_insert_overwrite_tbl_partition PARTITION (dt='20150617', ht='00') VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2')";
spark.sql(test_sql).collect().foreach(println);


/*testLoadDataLocalTable.scala*/
val test_sql =
  """CREATE TABLE testdb.load_data_local_into_table (str STRING, countVal INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '&'
LINES TERMINATED BY '\n'""";
spark.sql(test_sql).collect().foreach(println);


/*testLoadDataLocalTablePartition.scala*/

val test_sql =
  """CREATE TABLE testdb.load_data_local_into_partition (
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


/*testMSCKRepairTable.scala*/

val test_sql = "CREATE TABLE testdb.test_msck (id INT, val STRING) PARTITIONED BY(month INT)";
spark.sql(test_sql).collect().foreach(println);

/*testQuery.scala*/
val test_sql = "CREATE TABLE testdb.tbl4query (str STRING, countVal INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '&' LINES TERMINATED BY '\n'";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/test_file.txt' INTO TABLE testdb.tbl4query";
spark.sql(test_sql).collect().foreach(println);


/*testShowColumnsAndTblProperties.scala*/

val test_sql =
  """CREATE TABLE testdb.employees_props (
  name  STRING COMMENT 'Employee name'
 ,salary  FLOAT  COMMENT'Employee salary'
 ,subordinates ARRAY<STRING> COMMENT 'Names of subordinates'
 ,deductions  MAP<STRING, FLOAT> COMMENT  'Keys are deductions names, values are percentages'
 ,address  STRUCT<street:STRING,city:STRING, state:STRING, zip:INT> COMMENT 'Home address')
COMMENT 'Description of the table'
PARTITIONED BY (country STRING, state STRING)
TBLPROPERTIES ('creator'='HADOOP-QA','created_at'='2017-9-10 10:00:00', 'notes'='test show tblproperties')""";
spark.sql(test_sql).collect().foreach(println);


/*testInsertOverwriteTablePartition02.scala*/

val test_sql =
  """CREATE TABLE testdb.test_insert_overwrite_tbl_partition (
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

val test_sql =
  """CREATE TABLE testdb.src_test_insert_overwrite_tbl_partition (
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


val test_sql = "ALTER TABLE testdb.src_test_insert_overwrite_tbl_partition ADD PARTITION (country = 'US', state = 'CA')";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "ALTER TABLE testdb.src_test_insert_overwrite_tbl_partition ADD PARTITION (country = 'US', state = 'OR')";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "ALTER TABLE testdb.src_test_insert_overwrite_tbl_partition ADD PARTITION (country = 'US', state = 'IL')";
spark.sql(test_sql).collect().foreach(println);

val test_sql = "ALTER TABLE testdb.test_insert_overwrite_tbl_partition ADD PARTITION (country = 'US', state = 'CA')";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "ALTER TABLE testdb.test_insert_overwrite_tbl_partition ADD PARTITION (country = 'US', state = 'OR')";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "ALTER TABLE testdb.test_insert_overwrite_tbl_partition ADD PARTITION (country = 'US', state = 'IL')";
spark.sql(test_sql).collect().foreach(println);


val test_sql = """LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE testdb.src_test_insert_overwrite_tbl_partition PARTITION (country = 'US', state = 'CA')""";
spark.sql(test_sql).collect().foreach(println);

/*testUDF*/
val test_sql="CREATE TABLE testdb.spark_tbl4udf (id int)";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT INTO testdb.spark_tbl4udf VALUES (1), (2), (null)";
spark.sql(test_sql).collect().foreach(println);


/* testSampleTruncate */
val test_sql="CREATE TABLE testdb.tbl4sample (id int)";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT INTO testdb.tbl4sample VALUES (1), (2), (null)";
spark.sql(test_sql).collect().foreach(println);

val test_sql ="CREATE TABLE testdb.spark_insert_employee (name STRING, age INT, province STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'";
spark.sql(test_sql).collect().foreach(println);



val sqlContext = new org.apache.spark.sql.SQLContext(sc)
import sqlContext.implicits._
import org.apache.spark.sql.SaveMode

/* case to DF saveAsTable and insertInto table */
case class Employee(name: String, age: Int, province: String)
val employee = sc.parallelize(Employee("zhangsan", 31, "beijing")::Employee("wangwu" , 28, "hubei")::Employee("lisi", 44, "tianjin")::Employee("liping", 23, "guangdong")::Nil).toDF()
employee.write.mode(SaveMode.Overwrite).saveAsTable("testdb.spark_case_employee2")
val test_sql="TRUNCATE TABLE testdb.spark_case_employee2";
spark.sql(test_sql).collect().foreach(println);

/* case to DF with partition saveAsTable FOR insertInto table test */
employee.write.mode(SaveMode.Overwrite).partitionBy("province").saveAsTable("testdb.spark_case_employee_partition2");
val test_sql="TRUNCATE TABLE testdb.spark_case_employee_partition2";
spark.sql(test_sql).collect().foreach(println);

/* temp table saveAsTable For insertInto table test */
employee.registerTempTable("employee")
val query = sqlContext.sql("select name, age from (select * from employee where province = 'beijing') a where a.age >= 20 and a.age < 40")
query.write.mode(SaveMode.Overwrite).saveAsTable("testdb.spark_query_employee2")
val test_sql="TRUNCATE TABLE testdb.spark_query_employee2";
spark.sql(test_sql).collect().foreach(println);


/* temp table with partition saveAsTable FOR insertInto table test */
query.write.mode(SaveMode.Overwrite).partitionBy("age").saveAsTable("testdb.spark_query_employee_partition2")
val test_sql="TRUNCATE TABLE testdb.spark_query_employee_partition2";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
