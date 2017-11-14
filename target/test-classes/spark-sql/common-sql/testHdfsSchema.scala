// sqlContext from the previous example is used in this example.
// This is used to implicitly convert an RDD to a DataFrame.

val sqlContext = new org.apache.spark.sql.SQLContext(sc)
import sqlContext.implicits._
import org.apache.spark.sql.SaveMode

val hdfsPath="/user/hive/warehouse/test_schema"

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

val df = spark.read.option("mergeSchema", "false").parquet(hdfsPath)
df.printSchema()


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
val csvPath="/user/hive/warehouse/datafile.csv"
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
