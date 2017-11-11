val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

var data_source_sql="SELECT * FROM testdb.test_insert_overwrite_dir se WHERE se.country = 'US' and se.state = 'CA'";

import org.apache.hadoop.fs.FileSystem
import org.apache.hadoop.fs.Path
val fs=FileSystem.get(sc.hadoopConfiguration)


/* query data and write to HDFS dir */
val parquetPath="/user/hive/warehouse/testdb.db/spark_ca_employees_parquet"
if(fs.exists(new Path(parquetPath)))
  fs.delete(new Path(parquetPath),true)
spark.sql(data_source_sql).write.format("parquet").save(parquetPath);
/* load HDFS data to df */
val df_parquet = spark.read.load(parquetPath);
df_parquet.collect.foreach(println);

val df_parquet_query = spark.sql("SELECT * FROM parquet.`/user/hive/warehouse/testdb.db/spark_ca_employees_parquet`")
df_parquet_query.collect.foreach(println);

/* save df data to table */
var test_sql="DROP TABLE IF EXISTS testdb.spark_df_parquet";
spark.sql(test_sql).collect().foreach(println);
df_parquet.write.saveAsTable("testdb.spark_df_parquet")
df_parquet.write.insertInto("testdb.spark_df_parquet")

var test_sql="DROP TABLE IF EXISTS testdb.spark_df_parquet_query";
spark.sql(test_sql).collect().foreach(println);
df_parquet_query.write.saveAsTable("testdb.spark_df_parquet_query")
df_parquet_query.write.insertInto("testdb.spark_df_parquet_query")


/* query and verify data */
var test_sql="SELECT count(*) FROM testdb.spark_df_parquet";
spark.sql(test_sql).collect().foreach(println);
var test_sql="SELECT * FROM testdb.test_insert_overwrite_dir UNION SELECT * FROM testdb.spark_df_parquet";
spark.sql(test_sql).collect().foreach(println);
var test_sql="SELECT count(*) FROM testdb.spark_df_parquet_query";
spark.sql(test_sql).collect().foreach(println);
var test_sql="SELECT * FROM testdb.test_insert_overwrite_dir UNION SELECT * FROM testdb.spark_df_parquet_query";
spark.sql(test_sql).collect().foreach(println);
/* remove HDFS folder */
if(fs.exists(new Path(parquetPath)))
  fs.delete(new Path(parquetPath),true)


/* query data and write to HDFS dir */
val jsonPath="/user/hive/warehouse/testdb.db/spark_ca_employees_json"
if(fs.exists(new Path(jsonPath)))
  fs.delete(new Path(jsonPath),true)
spark.sql(data_source_sql).write.format("json").save(jsonPath);
/* load HDFS data to df */
val df_json = spark.read.format("json").load(jsonPath);
df_json.collect.foreach(println);

val df_json_query = spark.sql("SELECT * FROM json.`/user/hive/warehouse/testdb.db/spark_ca_employees_json`");
df_json_query.collect.foreach(println);

/* save df data to table */
var test_sql="DROP TABLE IF EXISTS testdb.spark_df_json";
spark.sql(test_sql).collect().foreach(println);
df_json.write.saveAsTable("testdb.spark_df_json");
df_json.write.insertInto("testdb.spark_df_json");

var test_sql="DROP TABLE IF EXISTS testdb.spark_df_json_query";
spark.sql(test_sql).collect().foreach(println);
df_json_query.write.saveAsTable("testdb.spark_df_json_query");
df_json_query.write.insertInto("testdb.spark_df_json_query");

/* query and verify data */
var test_sql="SELECT * FROM testdb.test_insert_overwrite_dir UNION SELECT * FROM testdb.spark_df_json";
spark.sql(test_sql).collect().foreach(println);
var test_sql="SELECT * FROM testdb.test_insert_overwrite_dir UNION SELECT * FROM testdb.spark_df_json_query";
spark.sql(test_sql).collect().foreach(println);
/* remove HDFS folder */
if(fs.exists(new Path(jsonPath)))
  fs.delete(new Path(jsonPath),true)




scala> df_json.write.saveAsTable("testdb.spark_df_json");
17/11/11 16:35:46 WARN task-result-getter-2 TaskSetManager (org.apache.spark.internal.Logging$class.logWarning(Logging.scala:66)): Lost task 1.0 in stage 107.0 (TID 2423, gh-data-hdp-qa02.corp.sankuai.com, executor 1): org.apache.spark.sql.AnalysisException: Attribute name "Federal Taxes" contains invalid character(s) among " ,;{}()\n\t=". Please use alias to rename it.;
at org.apache.spark.sql.execution.datasources.parquet.ParquetSchemaConverter$.checkConversionRequirement(ParquetSchemaConverter.scala:581)
at org.apache.spark.sql.execution.datasources.parquet.ParquetSchemaConverter$.checkFieldName(ParquetSchemaConverter.scala:567)
at org.apache.spark.sql.execution.datasources.parquet.ParquetSchemaConverter.convertField(ParquetSchemaConverter.scala:325)
at org.apache.spark.sql.execution.datasources.parquet.ParquetSchemaConverter.convertField(ParquetSchemaConverter.scala:321)
at org.apache.spark.sql.execution.datasources.parquet.ParquetSchemaConverter$$anonfun$convertField$1.apply(ParquetSchemaConverter.scala:534)
at org.apache.spark.sql.execution.datasources.parquet.ParquetSchemaConverter$$anonfun$convertField$1.apply(ParquetSchemaConverter.scala:533)
at scala.collection.IndexedSeqOptimized$class.foldl(IndexedSeqOptimized.scala:57)
at scala.collection.IndexedSeqOptimized$class.foldLeft(IndexedSeqOptimized.scala:66)
at scala.collection.mutable.ArrayOps$ofRef.foldLeft(ArrayOps.scala:186)
at org.apache.spark.sql.execution.datasources.parquet.ParquetSchemaConverter.convertField(ParquetSchemaConverter.scala:533)
at org.apache.spark.sql.execution.datasources.parquet.ParquetSchemaConverter.convertField(ParquetSchemaConverter.scala:321)
at org.apache.spark.sql.execution.datasources.parquet.ParquetSchemaConverter$$anonfun$convert$1.apply(ParquetSchemaConverter.scala:313)
at org.apache.spark.sql.execution.datasources.parquet.ParquetSchemaConverter$$anonfun$convert$1.apply(ParquetSchemaConverter.scala:313)
at scala.collection.TraversableLike$$anonfun$map$1.apply(TraversableLike.scala:234)
at scala.collection.TraversableLike$$anonfun$map$1.apply(TraversableLike.scala:234)
at scala.collection.Iterator$class.foreach(Iterator.scala:893)
at scala.collection.AbstractIterator.foreach(Iterator.scala:1336)
at scala.collection.IterableLike$class.foreach(IterableLike.scala:72)
at org.apache.spark.sql.types.StructType.foreach(StructType.scala:96)
at scala.collection.TraversableLike$class.map(TraversableLike.scala:234)
at org.apache.spark.sql.types.StructType.map(StructType.scala:96)
at org.apache.spark.sql.execution.datasources.parquet.ParquetSchemaConverter.convert(ParquetSchemaConverter.scala:313)
at org.apache.spark.sql.execution.datasources.parquet.ParquetWriteSupport.init(ParquetWriteSupport.scala:85)
at org.apache.parquet.hadoop.ParquetOutputFormat.getRecordWriter(ParquetOutputFormat.java:311)
at org.apache.parquet.hadoop.ParquetOutputFormat.getRecordWriter(ParquetOutputFormat.java:283)
at org.apache.spark.sql.execution.datasources.parquet.ParquetOutputWriter.<init>(ParquetOutputWriter.scala:37)
at org.apache.spark.sql.execution.datasources.parquet.ParquetFileFormat$$anon$1.newInstance(ParquetFileFormat.scala:145)
at org.apache.spark.sql.execution.datasources.FileFormatWriter$SingleDirectoryWriteTask.<init>(FileFormatWriter.scala:234)
at org.apache.spark.sql.execution.datasources.FileFormatWriter$.org$apache$spark$sql$execution$datasources$FileFormatWriter$$executeTask(FileFormatWriter.scala:182)
at org.apache.spark.sql.execution.datasources.FileFormatWriter$$anonfun$write$1$$anonfun$3.apply(FileFormatWriter.scala:129)
at org.apache.spark.sql.execution.datasources.FileFormatWriter$$anonfun$write$1$$anonfun$3.apply(FileFormatWriter.scala:128)
at org.apache.spark.scheduler.ResultTask.runTask(ResultTask.scala:87)
at org.apache.spark.scheduler.Task.run(Task.scala:99)
at org.apache.spark.executor.Executor$TaskRunner.run(Executor.scala:282)
at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1145)
at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:615)
at java.lang.Thread.run(Thread.java:745)




/* query data and write to HDFS dir */
val orcPath="/user/hive/warehouse/testdb.db/spark_ca_employees_orc"
if(fs.exists(new Path(orcPath)))
  fs.delete(new Path(orcPath),true)
spark.sql(data_source_sql).write.format("orc").save(orcPath);
/* load HDFS data to df */
val df_orc = spark.read.format("orc").load(orcPath);
df_orc.collect.foreach(println);

val df_orc_query = spark.sql("SELECT * FROM orc.`/user/hive/warehouse/testdb.db/spark_ca_employees_orc`")
df_orc_query.collect.foreach(println);

/* save df data to table */
var test_sql="DROP TABLE IF EXISTS testdb.spark_df_orc";
spark.sql(test_sql).collect().foreach(println);
df_orc.write.saveAsTable("testdb.spark_df_orc")
df_orc.write.insertInto("testdb.spark_df_orc")

var test_sql="DROP TABLE IF EXISTS testdb.spark_df_orc_query";
spark.sql(test_sql).collect().foreach(println);
df_orc_query.write.saveAsTable("testdb.spark_df_orc_query")
df_orc_query.write.insertInto("testdb.spark_df_orc_query")

/* query and verify data */
var test_sql="SELECT * FROM testdb.test_insert_overwrite_dir UNION SELECT * FROM testdb.spark_df_orc";
spark.sql(test_sql).collect().foreach(println);
var test_sql="SELECT * FROM testdb.test_insert_overwrite_dir UNION SELECT * FROM testdb.spark_df_orc_query";
spark.sql(test_sql).collect().foreach(println);
/* remove HDFS folder */
if(fs.exists(new Path(orcPath)))
  fs.delete(new Path(orcPath),true)

System.exit(0);
