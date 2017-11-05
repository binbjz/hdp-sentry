val test_sql="USE default";
spark.sql(test_sql).collect().foreach(println);

val test_sql="CREATE DATABASE mart_waimai WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE mart_waimai_new WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE mart_wmorg WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE origin_waimai WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02')";
spark.sql(test_sql).collect().foreach(println);

val test_sql="CREATE DATABASE ba_ups";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE dim";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE dw";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE mart_waimai_crm";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE origindb";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE origindb_delta";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE origin_dianping";
spark.sql(test_sql).collect().foreach(println);

:q
