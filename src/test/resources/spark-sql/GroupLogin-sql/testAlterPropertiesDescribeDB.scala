val test_sql="USE default";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DESCRIBE DATABASE EXTENDED mart_waimai";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER DATABASE mart_waimai SET DBPROPERTIES ('edited-by' = 'hadoop-new-qa')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE DATABASE EXTENDED mart_waimai";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DESCRIBE DATABASE EXTENDED dim";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER DATABASE dim SET DBPROPERTIES ('edited-by' = 'hadoop-new-qa')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE DATABASE EXTENDED dim";
spark.sql(test_sql).collect().foreach(println);

System.exit(0)
