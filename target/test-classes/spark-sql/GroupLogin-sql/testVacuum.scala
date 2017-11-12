val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);


/* testVacuum */

val test_sql="VACUUM mart_waimai.tbl4vacuum";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT * FROM mart_waimai.tbl4vacuum";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
