val test_sql="USE default";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT 1";
spark.sql(test_sql).collect().foreach(println);

:q
