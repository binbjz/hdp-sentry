val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SHOW PARTITIONS testdb.test_msck";
spark.sql(test_sql).collect().foreach(println);

/*使用MSCK修复分区*/
val test_sql="MSCK REPAIR TABLE testdb.test_msck";
spark.sql(test_sql).collect().foreach(println);
/*再次查看，发现已经成功更新元信息*/
val test_sql="SHOW PARTITIONS testdb.test_msck";
spark.sql(test_sql).collect().foreach(println);





val test_sql="USE testdb_spark";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SHOW PARTITIONS testdb_spark.test_msck";
spark.sql(test_sql).collect().foreach(println);

/*使用MSCK修复分区*/
val test_sql="MSCK REPAIR TABLE testdb_spark.test_msck";
spark.sql(test_sql).collect().foreach(println);
/*再次查看，发现已经成功更新元信息*/
val test_sql="SHOW PARTITIONS testdb_spark.test_msck";
spark.sql(test_sql).collect().foreach(println);

