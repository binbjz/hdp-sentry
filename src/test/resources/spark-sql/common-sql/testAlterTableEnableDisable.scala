val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb.test_enable_disable1 ENABLE NO_DROP";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.test_enable_disable1";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.test_enable_disable1 DISABLE NO_DROP";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.test_enable_disable1";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb.test_enable_disable2 ENABLE OFFLINE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.test_enable_disable2";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.test_enable_disable2 DISABLE OFFLINE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.test_enable_disable2";
spark.sql(test_sql).collect().foreach(println);

:q
