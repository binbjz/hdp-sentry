/*
* encrypt_spark_testdb
* spark_tbl4udf encrypt_id
*
* */

val test_sql="USE encrypt_spark_testdb";
spark.sql(test_sql).collect().foreach(println);

/* spark udf */

val squared = (s: Int) => {
  s * s
}
spark.udf.register("square", squared);

val test_sql="CREATE TABLE encrypt_spark_testdb.spark_tbl4udf (encrypt_id int)";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT INTO encrypt_spark_testdb.spark_tbl4udf VALUES (1), (2), (null)";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT encrypt_id, square(encrypt_id) as id_squared FROM encrypt_spark_testdb.spark_tbl4udf";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE encrypt_spark_testdb.spark_tbl4udf";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
