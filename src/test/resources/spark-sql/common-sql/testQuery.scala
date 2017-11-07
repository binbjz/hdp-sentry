val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);
/* test collect*/
val test_sql="SELECT str, concat_ws( ',' , collect_set(cast(countVal AS STRING))) FROM testdb.tbl4query GROUP BY str";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT str, count(*) as val FROM testdb.tbl4query GROUP BY str";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT count(*) FROM testdb.tbl4query";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT 1";
spark.sql(test_sql).collect().foreach(println);

:q
