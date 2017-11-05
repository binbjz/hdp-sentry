val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb.tbl4fileformat ADD PARTITION (year=2022, month=1, day=1) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb.db/tbl4fileformat/2022/01/01'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW PARTITIONS testdb.tbl4fileformat";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE EXTENDED testdb.tbl4fileformat PARTITION (year=2022, month=1, day=1)";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb.tbl4fileformat_external ADD PARTITION (year=2022, month=1, day=1) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb.db/tbl4fileformat_external/2022/01/01'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW PARTITIONS testdb.tbl4fileformat_external";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE EXTENDED testdb.tbl4fileformat_external PARTITION (year=2022, month=1, day=1)";
spark.sql(test_sql).collect().foreach(println);

:q
