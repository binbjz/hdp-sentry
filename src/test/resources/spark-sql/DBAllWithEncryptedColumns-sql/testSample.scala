val test_sql="USE encrypt_spark_testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT * FROM encrypt_spark_testdb.tbl4sample TABLESAMPLE(100.0 PERCENT) s";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT * FROM encrypt_spark_testdb.tbl4sample TABLESAMPLE(2 ROWS) s";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);

