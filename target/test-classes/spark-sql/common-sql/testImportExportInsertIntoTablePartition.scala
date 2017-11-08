val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET hive.exec.dynamic.partition=true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.exec.dynamic.partition.mode=nonstrict";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);

/* testImportExportPartition */

val test_sql="EXPORT TABLE testdb.src_import_export PARTITION (country = 'US', state = 'CA') TO '/tmp/import_export_partition'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM testdb.src_import_export";
spark.sql(test_sql).collect().foreach(println);

val test_sql="IMPORT TABLE testdb.import_export PARTITION (country = 'US', state = 'CA') FROM '/tmp/import_export_partition'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW PARTITIONS testdb.import_export";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM testdb.import_export";
spark.sql(test_sql).collect().foreach(println);


/* testInsertIntoTablePartition */

val test_sql="INSERT INTO testdb.src_insert_overwrite_tbl_partition PARTITION (dt='20150617', ht='00') VALUES ('alibaba', '10.0.0.3')";
spark.sql(test_sql).collect().foreach(println);
/*existing partition*/
val test_sql="INSERT INTO testdb.src_insert_overwrite_tbl_partition PARTITION (dt='20150617', ht='01') VALUES ('alibaba', '10.0.0.3')";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT name, ip FROM testdb.src_insert_overwrite_tbl_partition WHERE dt='20150617' and ht='00' AND name='alibaba'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT name, ip FROM testdb.src_insert_overwrite_tbl_partition WHERE dt='20150617' and ht='01' AND name='alibaba'";
spark.sql(test_sql).collect().foreach(println);

System.exit(0)
