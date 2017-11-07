val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

/*更改TABLE以将分区指向新位置*/
val test_sql="ALTER TABLE testdb.tbl4setlocation PARTITION (year=2011, month=1, day=1) SET LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb.db/tbl4setlocation_new/year=2011/month=1/day=1'";
spark.sql(test_sql).collect().foreach(println);
/*获取partition的真实hdfs路径*/
val test_sql="DESC FORMATTED testdb.tbl4setlocation partition (year=2011, month=1, day=1)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESC FORMATTED testdb.tbl4setlocation partition (year=2011, month=1, day=2)";
spark.sql(test_sql).collect().foreach(println);

:q




val test_sql="USE testdb_spark";
spark.sql(test_sql).collect().foreach(println);

/*更改TABLE以将分区指向新位置*/
val test_sql="ALTER TABLE testdb_spark.tbl4setlocation PARTITION (year=2011, month=1, day=1) SET LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb_spark.db/tbl4setlocation_new/year=2011/month=1/day=1'";
spark.sql(test_sql).collect().foreach(println);
/*获取partition的真实hdfs路径*/
val test_sql="DESC FORMATTED testdb_spark.tbl4setlocation partition (year=2011, month=1, day=1)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESC FORMATTED testdb_spark.tbl4setlocation partition (year=2011, month=1, day=2)";
spark.sql(test_sql).collect().foreach(println);

:q

