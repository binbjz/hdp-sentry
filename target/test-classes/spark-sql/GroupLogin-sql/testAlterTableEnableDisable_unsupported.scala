val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE mart_waimai.test_enable_disable1 ENABLE NO_DROP";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE mart_waimai.test_enable_disable1";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE mart_waimai.test_enable_disable1 DISABLE NO_DROP";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE mart_waimai.test_enable_disable1";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE mart_waimai.test_enable_disable2 ENABLE OFFLINE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE mart_waimai.test_enable_disable2";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE mart_waimai.test_enable_disable2 DISABLE OFFLINE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE mart_waimai.test_enable_disable2";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
