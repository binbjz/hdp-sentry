//encrypt_db4msck.test_msck=encrypt_val
//CREATE DATABASE encrypt_db4msck;
//DROP DATABASE encrypt_db4msck;

val test_sql="USE encrypt_db4msck";
spark.sql(test_sql).collect().foreach(println);

val test_sql="CREATE TABLE encrypt_db4msck.test_msck (id INT, encrypt_val STRING) PARTITIONED BY(month INT)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE encrypt_db4msck.test_msck ADD PARTITION (month=201602)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="INSERT INTO encrypt_db4msck.test_msck PARTITION (month=201602) VALUES (1, 'encrypt value1'), (2, 'encrypt value2')";
spark.sql(test_sql).collect().foreach(println);

/* testMSCKRepairTable */

val test_sql="SHOW PARTITIONS encrypt_db4msck.test_msck";
spark.sql(test_sql).collect().foreach(println);

import org.apache.hadoop.fs.FileSystem
import org.apache.hadoop.fs.Path
val fs=FileSystem.get(sc.hadoopConfiguration)

/*创建两个分区目录
dfs -mkdir /user/hive/warehouse/encrypt_db4msck.db/test_msck/month=201603;
dfs -mkdir /user/hive/warehouse/encrypt_db4msck.db/test_msck/month=201604;
*/
val partitionPath="/user/hive/warehouse/encrypt_db4msck.db/test_msck/month=201603"
if(fs.exists(new Path(partitionPath)))
  fs.delete(new Path(partitionPath),true)
if(!fs.exists(new Path(partitionPath)))
  fs.mkdirs(new Path(partitionPath))


val partitionPath="/user/hive/warehouse/encrypt_db4msck.db/test_msck/month=201604"
if(fs.exists(new Path(partitionPath)))
  fs.delete(new Path(partitionPath),true)
if(!fs.exists(new Path(partitionPath)))
  fs.mkdirs(new Path(partitionPath))

/*使用MSCK修复分区*/
val test_sql="MSCK REPAIR TABLE encrypt_db4msck.test_msck";
spark.sql(test_sql).collect().foreach(println);
/*再次查看，发现已经成功更新元信息*/
val test_sql="SHOW PARTITIONS encrypt_db4msck.test_msck";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT id, encrypt_val, month FROM encrypt_db4msck.test_msck";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT COUNT(*) FROM encrypt_db4msck.test_msck";
spark.sql(test_sql).collect().foreach(println);

val partitionPath="/user/hive/warehouse/encrypt_db4msck.db/test_msck/month=201603"
if(fs.exists(new Path(partitionPath)))
  fs.delete(new Path(partitionPath),true)

val partitionPath="/user/hive/warehouse/encrypt_db4msck.db/test_msck/month=201604"
if(fs.exists(new Path(partitionPath)))
  fs.delete(new Path(partitionPath),true)

val test_sql="DROP TABLE encrypt_db4msck.test_msck";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
