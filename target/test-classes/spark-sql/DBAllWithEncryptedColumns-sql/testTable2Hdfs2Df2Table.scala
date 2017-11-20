/*
* encrypt_spark_testdb
* spark_df_parquet
* spark_df_parquet_query
* spark_df_json
* spark_df_json_query
* spark_df_orc
* spark_df_orc_query
*
* */

val test_sql="USE encrypt_spark_testdb";
spark.sql(test_sql).collect().foreach(println);


val test_sql =
  """CREATE TABLE encrypt_spark_testdb.test_insert_overwrite_dir (
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

val test_sql = "ALTER TABLE encrypt_spark_testdb.test_insert_overwrite_dir ADD PARTITION (country = 'US', state = 'CA')";
spark.sql(test_sql).collect().foreach(println);

val test_sql =
  """LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE encrypt_spark_testdb.test_insert_overwrite_dir
PARTITION (country = 'US', state = 'CA')""";
spark.sql(test_sql).collect().foreach(println);

var data_source_sql="SELECT * FROM encrypt_spark_testdb.test_insert_overwrite_dir se WHERE se.country = 'US' and se.state = 'CA'";

import org.apache.hadoop.fs.FileSystem
import org.apache.hadoop.fs.Path
val fs=FileSystem.get(sc.hadoopConfiguration)


/* query data and write to HDFS dir */
val parquetPath="/user/hive/warehouse/encrypt_spark_testdb.db/spark_ca_employees_parquet"
if(fs.exists(new Path(parquetPath)))
  fs.delete(new Path(parquetPath),true)
spark.sql(data_source_sql).write.format("parquet").save(parquetPath);
/* load HDFS data to df */
val df_parquet = spark.read.load(parquetPath);
df_parquet.collect.foreach(println);

val df_parquet_query = spark.sql("SELECT * FROM parquet.`/user/hive/warehouse/encrypt_spark_testdb.db/spark_ca_employees_parquet`")
df_parquet_query.collect.foreach(println);

/* save df data to table */
df_parquet.write.mode(SaveMode.Overwrite).saveAsTable("encrypt_spark_testdb.spark_df_parquet")
df_parquet.write.insertInto("encrypt_spark_testdb.spark_df_parquet")

df_parquet_query.write.mode(SaveMode.Overwrite).saveAsTable("encrypt_spark_testdb.spark_df_parquet_query")
df_parquet_query.write.insertInto("encrypt_spark_testdb.spark_df_parquet_query")


/* query and verify data */
var test_sql="SELECT count(*) FROM encrypt_spark_testdb.spark_df_parquet";
spark.sql(test_sql).collect().foreach(println);
var test_sql="SELECT * FROM encrypt_spark_testdb.test_insert_overwrite_dir UNION SELECT * FROM encrypt_spark_testdb.spark_df_parquet";
spark.sql(test_sql).collect().foreach(println);
var test_sql="SELECT count(*) FROM encrypt_spark_testdb.spark_df_parquet_query";
spark.sql(test_sql).collect().foreach(println);
var test_sql="SELECT * FROM encrypt_spark_testdb.test_insert_overwrite_dir UNION SELECT * FROM encrypt_spark_testdb.spark_df_parquet_query";
spark.sql(test_sql).collect().foreach(println);
/* remove HDFS folder */
if(fs.exists(new Path(parquetPath)))
  fs.delete(new Path(parquetPath),true)


/* query data and write to HDFS dir */
val jsonPath="/user/hive/warehouse/encrypt_spark_testdb.db/spark_ca_employees_json"
if(fs.exists(new Path(jsonPath)))
  fs.delete(new Path(jsonPath),true)
spark.sql(data_source_sql).write.format("json").save(jsonPath);
/* load HDFS data to df */
val df_json = spark.read.format("json").load(jsonPath);
df_json.collect.foreach(println);

val df_json_query = spark.sql("SELECT * FROM json.`/user/hive/warehouse/encrypt_spark_testdb.db/spark_ca_employees_json`");
df_json_query.collect.foreach(println);

/* save df data to table */
df_json.write.mode(SaveMode.Overwrite).saveAsTable("encrypt_spark_testdb.spark_df_json");
df_json.write.insertInto("encrypt_spark_testdb.spark_df_json");

df_json_query.write.mode(SaveMode.Overwrite).saveAsTable("encrypt_spark_testdb.spark_df_json_query");
df_json_query.write.insertInto("encrypt_spark_testdb.spark_df_json_query");

/* query and verify data */
var test_sql="SELECT count(*) FROM encrypt_spark_testdb.spark_df_json";
spark.sql(test_sql).collect().foreach(println);
var test_sql="SELECT * FROM encrypt_spark_testdb.test_insert_overwrite_dir UNION SELECT * FROM encrypt_spark_testdb.spark_df_json";
spark.sql(test_sql).collect().foreach(println);
var test_sql="SELECT count(*) FROM encrypt_spark_testdb.spark_df_json_query";
spark.sql(test_sql).collect().foreach(println);
var test_sql="SELECT * FROM encrypt_spark_testdb.test_insert_overwrite_dir UNION SELECT * FROM encrypt_spark_testdb.spark_df_json_query";
spark.sql(test_sql).collect().foreach(println);
/* remove HDFS folder */
if(fs.exists(new Path(jsonPath)))
  fs.delete(new Path(jsonPath),true)


/* query data and write to HDFS dir */
val orcPath="/user/hive/warehouse/encrypt_spark_testdb.db/spark_ca_employees_orc"
if(fs.exists(new Path(orcPath)))
  fs.delete(new Path(orcPath),true)
spark.sql(data_source_sql).write.format("orc").save(orcPath);
/* load HDFS data to df */
val df_orc = spark.read.format("orc").load(orcPath);
df_orc.collect.foreach(println);

val df_orc_query = spark.sql("SELECT * FROM orc.`/user/hive/warehouse/encrypt_spark_testdb.db/spark_ca_employees_orc`")
df_orc_query.collect.foreach(println);

/* save df data to table */
df_orc.write.mode(SaveMode.Overwrite).saveAsTable("encrypt_spark_testdb.spark_df_orc")
df_orc.write.insertInto("encrypt_spark_testdb.spark_df_orc")

df_orc_query.write.mode(SaveMode.Overwrite).saveAsTable("encrypt_spark_testdb.spark_df_orc_query")
df_orc_query.write.insertInto("encrypt_spark_testdb.spark_df_orc_query")

/* query and verify data */
var test_sql="SELECT count(*) FROM encrypt_spark_testdb.spark_df_orc";
spark.sql(test_sql).collect().foreach(println);
var test_sql="SELECT * FROM encrypt_spark_testdb.test_insert_overwrite_dir UNION SELECT * FROM encrypt_spark_testdb.spark_df_orc";
spark.sql(test_sql).collect().foreach(println);
var test_sql="SELECT count(*) FROM encrypt_spark_testdb.spark_df_orc_query";
spark.sql(test_sql).collect().foreach(println);
var test_sql="SELECT * FROM encrypt_spark_testdb.test_insert_overwrite_dir UNION SELECT * FROM encrypt_spark_testdb.spark_df_orc_query";
spark.sql(test_sql).collect().foreach(println);
/* remove HDFS folder */
if(fs.exists(new Path(orcPath)))
  fs.delete(new Path(orcPath),true)

System.exit(0);
