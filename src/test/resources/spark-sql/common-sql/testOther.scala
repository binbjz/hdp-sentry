case class Person(name:String, age:Int, state:String)
sparkContext.parallelize(Person("Michael",29,"CA")::Person("Andy",30,"NY")::Person("Justin",19,"CA")::Person("Justin",25,"CA")::NIL).toDF().registerTempTable("people")
val query = sql("SELECT * FROM people")
query.printSchema
query.collect()
query.queryExecution.logical
query.queryExecution.analyzed
query.queryExecution.optimizedPlan
query.quercdyExecution.sparkPlan
query.show



val sqlContext = new org.apache.spark.sql.SQLContext(sc)
import sqlContext.implicits._
case class Person(name: String, age: Int)
val people = sc.textFile("").map(_.split(",")).map(p => Person(p(0), p(1).trime.toInt)).toDF()
people.registerTempTable("people")

val teenagers = sqlContext.sql("SELECT name, age FROM people WHERE age >= 13 AND age <= 19")
teenagers.map(t => "Name: " + t(0)).collect().foreach(println)
teenagers.map(t => "Name: " + t.getAs[String]("name")).collect().foreach(println)


val sqlContext = new org.apache.spark.sql.SQLContext(sc)
import org.apache.spark.sql.Row
import org.apache.spark.sql.types.{StructType, StructField, StringType}

val people = sc.textFile("")
val schemaString = "name age"
val schema = StructureTy

import org.apache.hadoop.fs.FileSystem
import org.apache.hadoop.fs.Path
val fs=FileSystem.get(sc.hadoopConfiguration)
val outPutPath="/tmp/abc"
if(fs.exists(new Path(outPutPath)))
  fs.delete(new Path(outPutPath),true)


case class Person(name:String,col1:Int,col2:String)
val sc = new org.apache.spark.SparkContext
val hiveContext = new org.apache.spark.sql.hive.HiveContext(sc)
import hiveContext.implicits._
hiveContext.sql("use default")
val data = sc.textFile("path").map(x=>x.split("\\s+")).map(x=>Person(x(0),x(1).toInt,x(2)))
data.toDF().registerTempTable("table1")
hiveContext.sql("select name,col1,col2 from table1")

hiveContext.sql("insert into table2 partition(date='2015-04-02') select name,col1,col2 from table1")
