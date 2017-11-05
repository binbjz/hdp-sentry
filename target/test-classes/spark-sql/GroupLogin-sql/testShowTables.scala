val test_sql="USE default";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TABLES";
spark.sql(test_sql).collect().foreach(println);

val test_sql="USE ba_ups";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TABLES";
spark.sql(test_sql).collect().foreach(println);

val test_sql="USE dim";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TABLES";
spark.sql(test_sql).collect().foreach(println);

val test_sql="USE dw";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TABLES";
spark.sql(test_sql).collect().foreach(println);

val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TABLES";
spark.sql(test_sql).collect().foreach(println);

val test_sql="USE mart_waimai_crm";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TABLES";
spark.sql(test_sql).collect().foreach(println);

val test_sql="USE mart_wmorg";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TABLES";
spark.sql(test_sql).collect().foreach(println);

val test_sql="USE origin_waimai";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TABLES";
spark.sql(test_sql).collect().foreach(println);

val test_sql="USE origindb";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TABLES";
spark.sql(test_sql).collect().foreach(println);

val test_sql="USE origindb_delta";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TABLES";
spark.sql(test_sql).collect().foreach(println);

val test_sql="USE origin_dianping";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TABLES";
spark.sql(test_sql).collect().foreach(println);

:q
