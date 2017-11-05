val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb.test_enable_disable_partition PARTITION(year = 2017, month = 8, day = 1) ENABLE NO_DROP";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.test_enable_disable_partition DROP PARTITION (year = 2017, month = 8, day = 1)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.test_enable_disable_partition PARTITION(year = 2017, month = 8, day = 1) DISABLE NO_DROP";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.test_enable_disable_partition DROP PARTITION (year = 2017, month = 8, day = 1)";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb.test_enable_disable_partition PARTITION(year = 2017, month = 8, day = 2) ENABLE OFFLINE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.test_enable_disable_partition DROP PARTITION (year = 2017, month = 8, day = 2)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.test_enable_disable_partition PARTITION(year = 2017, month = 8, day = 2) DISABLE OFFLINE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.test_enable_disable_partition DROP PARTITION (year = 2017, month = 8, day = 2)";
spark.sql(test_sql).collect().foreach(println);

:q
