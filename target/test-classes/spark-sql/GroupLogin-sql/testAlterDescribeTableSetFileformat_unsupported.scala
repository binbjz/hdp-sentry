/*
* mart_waimai.log_messages -> testdb.tbl4fileformat
*
* */
val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DESCRIBE EXTENDED mart_waimai.log_messages PARTITION (year=2011, month=1, day=1)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE mart_waimai.log_messages PARTITION (year=2011, month=1, day=1) SET FILEFORMAT SEQUENCEFILE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE EXTENDED mart_waimai.log_messages PARTITION (year=2011, month=1, day=1)";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DESCRIBE EXTENDED mart_waimai.log_messages_external";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE mart_waimai.log_messages_external SET FILEFORMAT SEQUENCEFILE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE EXTENDED mart_waimai.log_messages_external";
spark.sql(test_sql).collect().foreach(println);

import org.apache.hadoop.fs.FileSystem
import org.apache.hadoop.fs.Path
val fs=FileSystem.get(sc.hadoopConfiguration)

/*
dfs -rm -r /user/hive/warehouse/mart_waimai.db/log_messages_external;
*/
val partitionPath="/user/hive/warehouse/mart_waimai.db/log_messages_external"
if(fs.exists(new Path(partitionPath)))
  fs.delete(new Path(partitionPath),true)
if(!fs.exists(new Path(partitionPath)))
  fs.mkdirs(new Path(partitionPath))

System.exit(0);
