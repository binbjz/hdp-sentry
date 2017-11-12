val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);

/* spark udf */

val squared = (s: Int) => {
  s * s
}
spark.udf.register("square", squared);

val test_sql="SELECT id, square(id) as id_squared FROM mart_waimai.tbl4udf";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
