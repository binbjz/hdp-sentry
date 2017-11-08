val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.exec.dynamic.partition=true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.exec.dynamic.partition.mode=nonstrict";
spark.sql(test_sql).collect().foreach(println);


/* testInsertOverwriteTable */

val test_sql="INSERT OVERWRITE TABLE testdb.insert_overwrite_tbl SELECT name, ip FROM testdb.src_insert_overwrite_tbl WHERE name='meituan'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM testdb.insert_overwrite_tbl";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT OVERWRITE TABLE testdb.insert_overwrite_tbl SELECT * FROM testdb.src_insert_overwrite_tbl";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM testdb.insert_overwrite_tbl";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT ROW_NUMBER() OVER(PARTITION BY ip ORDER BY ip DESC) ID, name, ip FROM testdb.src_insert_overwrite_tbl";
spark.sql(test_sql).collect().foreach(println);

/* testInsertOverwriteTablePartition */

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


val test_sql="SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data";
spark.sql(test_sql).collect().foreach(println);


/* testLoadDataLocalTable */

val test_sql="""LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/test_file.txt'
INTO TABLE testdb.load_data_local_into_table""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT * FROM testdb.load_data_local_into_table";
spark.sql(test_sql).collect().foreach(println);


/* testLoadDataLocalTablePartition */

val test_sql="""LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE testdb.load_data_local_into_partition
PARTITION (country = 'US', state = 'CA')""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT * FROM testdb.load_data_local_into_partition";
spark.sql(test_sql).collect().foreach(println);

System.exit(0)
