val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

/*获取table的真实hdfs路径*/
val test_sql="DESC FORMATTED testdb.tbl4setlocation";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.tbl4setlocation SET LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb.db/tbl4setlocation_new'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESC FORMATTED testdb.tbl4setlocation";
spark.sql(test_sql).collect().foreach(println);

:q



val test_sql="USE testdb_spark";
spark.sql(test_sql).collect().foreach(println);

/*获取table的真实hdfs路径*/
val test_sql="DESC FORMATTED testdb_spark.tbl4setlocation";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb_spark.tbl4setlocation SET LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb_spark.db/tbl4setlocation_new'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESC FORMATTED testdb_spark.tbl4setlocation";
spark.sql(test_sql).collect().foreach(println);

:q

