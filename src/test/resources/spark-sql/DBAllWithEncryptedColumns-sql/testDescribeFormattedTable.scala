//encrypt_db4alter.tbl4descformatted=encrypt_server,encrypt_message
//CREATE DATABASE encrypt_db4alter;
//DROP DATABASE encrypt_db4alter;

val test_sql="USE encrypt_db4alter";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""CREATE TABLE IF NOT EXISTS encrypt_db4alter.tbl4descformatted (hms INT, severity STRING, encrypt_server STRING, process_id INT, encrypt_message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'""";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE encrypt_db4alter.tbl4descformatted ADD PARTITION (year = 2011, month = 1, day = 1)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE encrypt_db4alter.tbl4descformatted ADD PARTITION (year = 2011, month = 1, day = 2)";
spark.sql(test_sql).collect().foreach(println);

/*
dfs -ls /user/hive/warehouse/encrypt_db4alter.db/tbl4descformatted/year=2011/month=1/day=1;
dfs -ls /user/hive/warehouse/encrypt_db4alter.db/tbl4descformatted/year=2011/month=1/day=2;
dfs -mkdir -p /user/hive/warehouse/encrypt_db4alter.db/tbl4descformatted_new/year=2011/month=1/day=2;
*/

import org.apache.hadoop.fs.FileSystem
import org.apache.hadoop.fs.Path
val fs=FileSystem.get(sc.hadoopConfiguration)

val partitionPath="/user/hive/warehouse/encrypt_db4alter.db/tbl4descformatted_new/year=2011/month=1/day=2"
if(fs.exists(new Path(partitionPath)))
  fs.delete(new Path(partitionPath),true)
if(!fs.exists(new Path(partitionPath)))
  fs.mkdirs(new Path(partitionPath))

val test_sql="ALTER TABLE encrypt_db4alter.tbl4descformatted PARTITION (year = 2011, month = 1, day = 2) SET LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/encrypt_db4alter.db/tbl4descformatted_new/year=2011/month=1/day=2'";
spark.sql(test_sql).collect().foreach(println);

//获取table的真实hdfs路径
val test_sql="DESC FORMATTED encrypt_db4alter.tbl4descformatted";
spark.sql(test_sql).collect().foreach(println);
//获取partition的真实hdfs路径
val test_sql="DESC FORMATTED encrypt_db4alter.tbl4descformatted partition (year = 2011, month = 1, day =1)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESC FORMATTED encrypt_db4alter.tbl4descformatted partition (year = 2011, month = 1, day =2)";
spark.sql(test_sql).collect().foreach(println);
//使用hadoop fs -rmr 命令删除分区的HDFS副本
//dfs -rm -r /user/hive/warehouse/encrypt_db4alter.db/tbl4descformatted;
//dfs -rm -r /user/hive/warehouse/encrypt_db4alter.db/tbl4descformatted_new;

val path="/user/hive/warehouse/encrypt_db4alter.db/tbl4descformatted"
if(fs.exists(new Path(path)))
  fs.delete(new Path(path),true)

val newpath="/user/hive/warehouse/encrypt_db4alter.db/tbl4descformatted_new"
if(fs.exists(new Path(newpath)))
  fs.delete(new Path(newpath),true)

val test_sql="DROP TABLE encrypt_db4alter.tbl4descformatted";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
