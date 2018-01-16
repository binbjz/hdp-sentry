val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);

import org.apache.hadoop.fs.FileSystem
import org.apache.hadoop.fs.Path
val fs=FileSystem.get(sc.hadoopConfiguration)

/*
dfs -rm -r /user/hive/warehouse/mart_waimai.db/log_messages_external;
*/
val partitionPath="/user/hive/warehouse/mart_waimai.db/dim_ad_cpc_activity_poi_new/dt=20210103"
if(fs.exists(new Path(partitionPath)))
  fs.delete(new Path(partitionPath),true)
if(!fs.exists(new Path(partitionPath)))
  fs.mkdirs(new Path(partitionPath))

val test_sql="ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi PARTITION (dt=20210103) SET LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/mart_waimai.db/dim_ad_cpc_activity_poi_new/dt=20210103'";
spark.sql(test_sql).collect().foreach(println);
/* 获取partition的真实hdfs路径 */
val test_sql="DESC FORMATTED mart_waimai.dim_ad_cpc_activity_poi PARTITION (dt=20210102)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESC FORMATTED mart_waimai.dim_ad_cpc_activity_poi PARTITION (dt=20210103)";
spark.sql(test_sql).collect().foreach(println);
/* 删除分区的HDFS副本
dfs -rm -r /user/hive/warehouse/mart_waimai.db/dim_ad_cpc_activity_poi
dfs -rm -r /user/hive/warehouse/mart_waimai.db/dim_ad_cpc_activity_poi_new;
*/
val partitionPath="/user/hive/warehouse/mart_waimai.db/dim_ad_cpc_activity_poi"
if(fs.exists(new Path(partitionPath)))
  fs.delete(new Path(partitionPath),true)
val partitionPath="/user/hive/warehouse/mart_waimai.db/dim_ad_cpc_activity_poi_new"
if(fs.exists(new Path(partitionPath)))
  fs.delete(new Path(partitionPath),true)

System.exit(0);
