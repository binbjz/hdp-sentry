//encrypt_db4data.encrypt_import_export=encrypt_name,encrypt_salary
//encrypt_db4data.encrypt_tgt_import_export=encrypt_name,encrypt_salary
//CREATE DATABASE encrypt_db4data;
//DROP DATABASE encrypt_db4data;

val test_sql="USE encrypt_db4data";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""CREATE TABLE encrypt_db4data.encrypt_import_export (
 encrypt_name STRING
 ,encrypt_salary FLOAT
 ,subordinates ARRAY<STRING>
 ,deductions MAP<STRING, FLOAT>
 ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""CREATE TABLE encrypt_db4data.encrypt_tgt_import_export (
encrypt_name STRING
 ,encrypt_salary FLOAT
 ,subordinates ARRAY<STRING>
 ,deductions MAP<STRING, FLOAT>
 ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/source-data";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE encrypt_db4data.encrypt_import_export
PARTITION (country = 'US', state = 'CA')""";
spark.sql(test_sql).collect().foreach(println);

/*
dfs -cat /user/hive/warehouse/encrypt_db4data.db/encrypt_import_export/country=US/state=CA/california-employees.csv;
dfs -count /user/hive/warehouse/encrypt_db4data.db/encrypt_import_export/country=US/state=CA/california-employees.csv;

dfs -copyToLocal /user/hive/warehouse/encrypt_db4data.db/encrypt_import_export/country=US/state=CA/california-employees.csv /tmp/california-employees.csv;
!ls -l /tmp/california-employees.csv;
!rm -r /tmp/california-employees.csv;
*/

//导出分区并且导入到分区表分区
val test_sql="EXPORT TABLE encrypt_db4data.encrypt_import_export PARTITION (country = 'US', state = 'CA') TO '/tmp/employee'";
spark.sql(test_sql).collect().foreach(println);
//dfs -cat /tmp/employee/country=US/state=CA/california-employees.csv;

val test_sql="IMPORT TABLE encrypt_db4data.encrypt_tgt_import_export PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW PARTITIONS encrypt_db4data.encrypt_tgt_import_export";
spark.sql(test_sql).collect().foreach(println);

//dfs -rm -r /tmp/employee;

import org.apache.hadoop.fs.FileSystem
import org.apache.hadoop.fs.Path
val fs=FileSystem.get(sc.hadoopConfiguration)

if(fs.exists(new Path("/tmp/employee")))
  fs.delete(new Path("/tmp/employee"),true)

val test_sql="DROP TABLE encrypt_db4data.encrypt_import_export";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE encrypt_db4data.encrypt_tgt_import_export";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
