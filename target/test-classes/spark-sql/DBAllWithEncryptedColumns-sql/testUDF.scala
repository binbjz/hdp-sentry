/*
* encrypt_spark_testdb
* tbl4udf id
*
* */

val test_sql="USE encrypt_spark_testdb";
spark.sql(test_sql).collect().foreach(println);

/* spark udf */

val squared = (s: Int) => {
  s * s
}
spark.udf.register("square", squared);

val test_sql="SELECT id, square(id) as id_squared FROM encrypt_spark_testdb.tbl4udf";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
