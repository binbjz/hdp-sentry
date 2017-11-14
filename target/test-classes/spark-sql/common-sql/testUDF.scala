val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

/* spark udf */

val squared = (s: Int) => {
  s * s
}
spark.udf.register("square", squared);

val test_sql="SELECT id, square(id) as id_squared FROM testdb.spark_tbl4udf";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
