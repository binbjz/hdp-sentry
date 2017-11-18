val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT * FROM mart_waimai.tbl4sample TABLESAMPLE(100.0 PERCENT) s";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT * FROM mart_waimai.tbl4sample TABLESAMPLE(2 ROWS) s";
spark.sql(test_sql).collect().foreach(println);

val test_sql="TRUNCATE TABLE mart_waimai.tbl4sample";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT * FROM mart_waimai.tbl4sample";
spark.sql(test_sql).collect().foreach(println);
System.exit(0);

