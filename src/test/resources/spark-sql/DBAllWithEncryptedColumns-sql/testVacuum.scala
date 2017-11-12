val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);


/* testVacuum */

val test_sql="VACUUM testdb.tbl4vacuum";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT * FROM testdb.tbl4vacuum";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
