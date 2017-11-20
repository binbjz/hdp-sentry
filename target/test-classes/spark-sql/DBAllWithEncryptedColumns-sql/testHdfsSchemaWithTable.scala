/*
* encrypt_spark_testdb
* spark_merge_schema_true double
* spark_merge_schema_false double
*
* */

// sqlContext from the previous example is used in this example.
// This is used to implicitly convert an RDD to a DataFrame.
import sqlContext.implicits._
import org.apache.spark.sql.SaveMode

val hdfsPath="/user/hive/warehouse/encrypt_spark_testdb.db/test_schema"

// Create a simple DataFrame, stored into a partition directory
val df = sc.makeRDD(1 to 5).map(i => (i, i * 2)).toDF("single", "double")
df.write.mode(SaveMode.Overwrite).parquet(hdfsPath + "/key=1")
val df = spark.read.parquet(hdfsPath + "/key=1")
df.printSchema()

// Create another DataFrame in a new partition directory,
// adding a new column and dropping an existing column
val df = sc.makeRDD(6 to 10).map(i => (i, i * 3)).toDF("single", "triple")
df.write.mode(SaveMode.Overwrite).parquet(hdfsPath + "/key=2")
val df = spark.read.parquet(hdfsPath + "/key=2")
df.printSchema()

// Read the partitioned table
val df = spark.read.option("mergeSchema", "true").parquet(hdfsPath)
df.printSchema()
df.write.mode(SaveMode.Overwrite).saveAsTable("encrypt_spark_testdb.spark_merge_schema_true")
val test_sql="SELECT * FROM encrypt_spark_testdb.spark_merge_schema_true ORDER BY 1";
spark.sql(test_sql).collect().foreach(println);


val df = spark.read.option("mergeSchema", "false").parquet(hdfsPath)
df.printSchema()
df.write.partitionBy("key").mode(SaveMode.Overwrite).saveAsTable("encrypt_spark_testdb.spark_merge_schema_false")
val test_sql="SELECT * FROM encrypt_spark_testdb.spark_merge_schema_false ORDER BY 1";
spark.sql(test_sql).collect().foreach(println);

// The final schema consists of all 3 columns in the Parquet files together
// with the partitioning column appeared in the partition directory paths.
// root
// |-- single: int (nullable = true)
// |-- double: int (nullable = true)
// |-- triple: int (nullable = true)
// |-- key : int (nullable = true)


import org.apache.hadoop.fs.FileSystem
import org.apache.hadoop.fs.Path
val fs=FileSystem.get(sc.hadoopConfiguration)

/* cleanup HDFS dir */
if(fs.exists(new Path(hdfsPath)))
  fs.delete(new Path(hdfsPath),true)


/* cleanup HDFS dir */
val csvPath="/user/hive/warehouse/encrypt_spark_testdb.db/datafile.csv"
if(fs.exists(new Path(csvPath)))
  fs.delete(new Path(csvPath),true)
/* RDD save to CSV file */
val df = sc.makeRDD(1 to 5).map(i => (i, i * 2))
df.saveAsTextFile(csvPath)
val input = sc.textFile(csvPath)
input.first
input.collect.foreach(println)
/* cleanup HDFS dir */
if(fs.exists(new Path(csvPath)))
  fs.delete(new Path(csvPath),true)

System.exit(0);
