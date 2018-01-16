val test_sql="USE default";
spark.sql(test_sql).collect().foreach(println);

/* spark udf */

val squared = (s: Int) => {
  s * s
}
spark.udf.register("square", squared);

val test_sql="SELECT square(2) as id_squared";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
