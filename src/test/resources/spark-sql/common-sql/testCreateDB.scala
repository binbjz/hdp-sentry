val test_sql="USE default";
spark.sql(test_sql).collect().foreach(println);

val test_sql="CREATE DATABASE db4create WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE db4create_no_privilege WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW DATABASES LIKE 'db4create*'";
spark.sql(test_sql).collect().foreach(println);

:q
