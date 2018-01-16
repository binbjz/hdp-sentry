val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);

import org.apache.hadoop.fs.FileSystem
import org.apache.hadoop.fs.Path
val fs=FileSystem.get(sc.hadoopConfiguration)

/*创建两个分区目录
dfs -mkdir /user/hive/warehouse/mart_waimai.db/dim_ad_cpc_activity_poi/dt=20180102;
dfs -mkdir /user/hive/warehouse/mart_waimai.db/dim_ad_cpc_activity_poi/dt=20180103;
*/
val partitionPath="/user/hive/warehouse/mart_waimai.db/dim_ad_cpc_activity_poi/dt=20180102"
if(fs.exists(new Path(partitionPath)))
  fs.delete(new Path(partitionPath),true)
if(!fs.exists(new Path(partitionPath)))
  fs.mkdirs(new Path(partitionPath))

val partitionPath="/user/hive/warehouse/mart_waimai.db/dim_ad_cpc_activity_poi/dt=20180103"
if(fs.exists(new Path(partitionPath)))
  fs.delete(new Path(partitionPath),true)
if(!fs.exists(new Path(partitionPath)))
  fs.mkdirs(new Path(partitionPath))

/* 使用MSCK修复分区 */
val test_sql="MSCK REPAIR TABLE mart_waimai.dim_ad_cpc_activity_poi";
spark.sql(test_sql).collect().foreach(println);
/* 再次查看，发现已经成功更新元信息 */
val test_sql="SHOW PARTITIONS mart_waimai.dim_ad_cpc_activity_poi";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi DROP PARTITION (dt=20180102)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi DROP PARTITION (dt=20180103)";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
