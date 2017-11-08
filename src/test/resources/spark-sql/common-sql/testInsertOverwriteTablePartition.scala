val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET hive.exec.dynamic.partition=true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.exec.dynamic.partition.mode=nonstrict";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT OVERWRITE TABLE testdb.insert_overwrite_tbl_partition PARTITION (dt='20150617', ht='00') SELECT name, ip FROM testdb.src_insert_overwrite_tbl_partition WHERE dt='20150617' and ht='00' AND name='meituan'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM testdb.insert_overwrite_tbl_partition";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT OVERWRITE TABLE testdb.insert_overwrite_tbl_partition PARTITION (dt, ht) SELECT * FROM testdb.src_insert_overwrite_tbl_partition WHERE dt='20150617' AND name='baidu'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM testdb.insert_overwrite_tbl_partition";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT OVERWRITE TABLE testdb.insert_overwrite_tbl_partition PARTITION (dt='20150617', ht) SELECT name, ip, ht FROM testdb.src_insert_overwrite_tbl_partition WHERE dt='20150617' and ht='00'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM testdb.insert_overwrite_tbl_partition";
spark.sql(test_sql).collect().foreach(println);

:q





val test_sql="USE testdb_spark";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET hive.exec.dynamic.partition=true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.exec.dynamic.partition.mode=nonstrict";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT OVERWRITE TABLE testdb_spark.insert_overwrite_tbl_partition PARTITION (dt='20150617', ht='00') SELECT name, ip FROM testdb.src_insert_overwrite_tbl_partition WHERE dt='20150617' and ht='00' AND name='meituan'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM testdb_spark.insert_overwrite_tbl_partition";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT OVERWRITE TABLE testdb_spark.insert_overwrite_tbl_partition PARTITION (dt, ht) SELECT * FROM testdb.src_insert_overwrite_tbl_partition WHERE dt='20150617' AND name='baidu'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM testdb_spark.insert_overwrite_tbl_partition";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT OVERWRITE TABLE testdb_spark.insert_overwrite_tbl_partition PARTITION (dt='20150617', ht) SELECT name, ip, ht FROM testdb.src_insert_overwrite_tbl_partition WHERE dt='20150617' and ht='00'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM testdb_spark.insert_overwrite_tbl_partition";
spark.sql(test_sql).collect().foreach(println);

:q

