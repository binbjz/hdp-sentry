val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT INTO mart_waimai.partition_table001 PARTITION (dt='20150617', ht='00') VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2'), ('alibaba', '10.0.0.3')";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET hive.exec.dynamic.partition=true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.exec.dynamic.partition.mode=nonstrict";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT OVERWRITE TABLE mart_waimai.partition_table002 PARTITION (dt='20150617', ht='00') SELECT name, ip FROM mart_waimai.partition_table001 WHERE dt='20150617' and ht='00' AND name='meituan'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM mart_waimai.partition_table002";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT OVERWRITE TABLE mart_waimai.partition_table002 PARTITION (dt, ht) SELECT * FROM mart_waimai.partition_table001 WHERE dt='20150617' AND name='baidu'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM mart_waimai.partition_table002";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT OVERWRITE TABLE mart_waimai.partition_table002 PARTITION (dt='20150617', ht) SELECT name, ip, ht FROM mart_waimai.partition_table001 WHERE dt='20150617' and ht='00' AND name='alibaba'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM mart_waimai.partition_table002";
spark.sql(test_sql).collect().foreach(println);

:q
