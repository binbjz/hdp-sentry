val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);


/* testMSCKRepairTable */

val test_sql="SHOW PARTITIONS testdb.test_msck";
spark.sql(test_sql).collect().foreach(println);

/*使用MSCK修复分区*/
val test_sql="MSCK REPAIR TABLE testdb.test_msck";
spark.sql(test_sql).collect().foreach(println);
/*再次查看，发现已经成功更新元信息*/
val test_sql="SHOW PARTITIONS testdb.test_msck";
spark.sql(test_sql).collect().foreach(println);


/* testTableAnalyze */

val test_sql="ANALYZE TABLE testdb.tbl4analyze COMPUTE STATISTICS FOR columns name, salary";
spark.sql(test_sql).collect().foreach(println);

/* 只搜集分区*/

val test_sql="ANALYZE TABLE testdb.tbl4analyze PARTITION (country = 'US', state = 'CA') COMPUTE STATISTICS";
spark.sql(test_sql).collect().foreach(println);

/* 如果执行,则同时搜集分区间OR/CA/IL*/

val test_sql="ANALYZE TABLE testdb.tbl4analyze PARTITION (country = 'US', state)  COMPUTE STATISTICS";
spark.sql(test_sql).collect().foreach(println);


/* 如果执行 搜集所有分区*/

val test_sql="ANALYZE TABLE testdb.tbl4analyze PARTITION (country, state) COMPUTE STATISTICS";
spark.sql(test_sql).collect().foreach(println);


/* 查看分区的统计信息*/

val test_sql="DESCRIBE EXTENDED testdb.tbl4analyze";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DESCRIBE EXTENDED testdb.tbl4analyze PARTITION (country = 'US', state = 'CA')";
spark.sql(test_sql).collect().foreach(println);


/* testAddRenameDropShowPartition */

val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb.tbl4partition ADD PARTITION (day=20110104)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.tbl4partition PARTITION (day=20110104) RENAME TO PARTITION (day=20110107)";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT id, part, quantity FROM testdb.tbl4partition WHERE day >= 20110102 AND day < 20110104 AND quantity < 4";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.tbl4partition PARTITION (day=20110102) RENAME TO PARTITION (day=20110109)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW PARTITIONS testdb.tbl4partition";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb.tbl4partition DROP PARTITION (day=20110103)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW PARTITIONS testdb.tbl4partition";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
