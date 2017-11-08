val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT INTO testdb.src_insert_overwrite_tbl_partition PARTITION (dt='20150617', ht='00') VALUES ('alibaba', '10.0.0.3')";
spark.sql(test_sql).collect().foreach(println);
/*existing partition*/
val test_sql="INSERT INTO testdb.src_insert_overwrite_tbl_partition PARTITION (dt='20150617', ht='01') VALUES ('alibaba', '10.0.0.3')";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET hive.exec.dynamic.partition=true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.exec.dynamic.partition.mode=nonstrict";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT name, ip FROM testdb.src_insert_overwrite_tbl_partition WHERE dt='20150617' and ht='00' AND name='alibaba'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT name, ip FROM testdb.src_insert_overwrite_tbl_partition WHERE dt='20150617' and ht='01' AND name='alibaba'";
spark.sql(test_sql).collect().foreach(println);

:q



val test_sql="USE testdb_spark";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT INTO testdb_spark.src_insert_overwrite_tbl_partition PARTITION (dt='20150617', ht='00') VALUES ('alibaba', '10.0.0.3')";
spark.sql(test_sql).collect().foreach(println);
/*existing partition*/
val test_sql="INSERT INTO testdb_spark.src_insert_overwrite_tbl_partition PARTITION (dt='20150617', ht='01') VALUES ('alibaba', '10.0.0.3')";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET hive.exec.dynamic.partition=true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.exec.dynamic.partition.mode=nonstrict";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT name, ip FROM testdb_spark.src_insert_overwrite_tbl_partition WHERE dt='20150617' and ht='00' AND name='alibaba'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT name, ip FROM testdb_spark.src_insert_overwrite_tbl_partition WHERE dt='20150617' and ht='01' AND name='alibaba'";
spark.sql(test_sql).collect().foreach(println);

:q

