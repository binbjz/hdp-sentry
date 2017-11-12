val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

/* testAlterDescribeTableSetLocation */

import org.apache.hadoop.fs.FileSystem
import org.apache.hadoop.fs.Path
val fs=FileSystem.get(sc.hadoopConfiguration)

val partitionPath="/user/hive/warehouse/testdb.db/tbl4setlocation_new"
if(fs.exists(new Path(partitionPath)))
  fs.delete(new Path(partitionPath),true)
if(!fs.exists(new Path(partitionPath)))
  fs.mkdirs(new Path(partitionPath))

val partitionPath="/user/hive/warehouse/testdb.db/tbl4setlocation_new/year=2011/month=1/day=1"
if(fs.exists(new Path(partitionPath)))
  fs.delete(new Path(partitionPath),true)
if(!fs.exists(new Path(partitionPath)))
  fs.mkdirs(new Path(partitionPath))


/*获取table的真实hdfs路径*/
val test_sql="DESC FORMATTED testdb.tbl4setlocation";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.tbl4setlocation SET LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb.db/tbl4setlocation_new'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESC FORMATTED testdb.tbl4setlocation";
spark.sql(test_sql).collect().foreach(println);

/* test AlterDescribeTableSetLocationPartition */

/*更改TABLE以将分区指向新位置*/
val test_sql="ALTER TABLE testdb.tbl4setlocation PARTITION (year=2011, month=1, day=1) SET LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb.db/tbl4setlocation_new/year=2011/month=1/day=1'";
spark.sql(test_sql).collect().foreach(println);
/*获取partition的真实hdfs路径*/
val test_sql="DESC FORMATTED testdb.tbl4setlocation partition (year=2011, month=1, day=1)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESC FORMATTED testdb.tbl4setlocation partition (year=2011, month=1, day=2)";
spark.sql(test_sql).collect().foreach(println);

val partitionPath="/user/hive/warehouse/testdb.db/tbl4setlocation_new"
if(fs.exists(new Path(outPutPath)))
  fs.delete(new Path(outPutPath),true)


/* test Alter Table Add Partition Location */

val test_sql="ALTER TABLE testdb.tbl4fileformat ADD PARTITION (year=2022, month=1, day=1) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb.db/tbl4fileformat/2022/01/01'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW PARTITIONS testdb.tbl4fileformat";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE EXTENDED testdb.tbl4fileformat PARTITION (year=2022, month=1, day=1)";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb.tbl4fileformat_external ADD PARTITION (year=2022, month=1, day=1) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb.db/tbl4fileformat_external/2022/01/01'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW PARTITIONS testdb.tbl4fileformat_external";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE EXTENDED testdb.tbl4fileformat_external PARTITION (year=2022, month=1, day=1)";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
