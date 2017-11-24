/*
* encrypt_spark_testdb
* tbl4sample encrypt_id
*
* */

val test_sql="USE encrypt_spark_testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="CREATE TABLE encrypt_spark_testdb.tbl4sample (encrypt_id int)";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT INTO encrypt_spark_testdb.tbl4sample VALUES (1), (2), (null)";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT * FROM encrypt_spark_testdb.tbl4sample TABLESAMPLE(100.0 PERCENT) s";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT * FROM encrypt_spark_testdb.tbl4sample TABLESAMPLE(2 ROWS) s";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE encrypt_spark_testdb.tbl4sample";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
