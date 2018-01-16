val test_sql="USE origin_waimai";
spark.sql(test_sql).collect().foreach(println);

/* QUERY FROM VIEW */
val test_sql="SELECT * FROM origin_waimai.waimai_safe_order";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""SELECT binded_phone
      ,common_ext
      ,recipient_address
      ,recipient_name
      ,recipient_phone
FROM origin_waimai.waimai_safe_order""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="USE origindb";
spark.sql(test_sql).collect().foreach(println);

/* QUERY FROM TABLE */
val test_sql="SELECT * FROM origindb.waimai_order_shard__wm";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""SELECT binded_phone
      ,common_ext
      ,recipient_address
      ,recipient_name
      ,recipient_phone
FROM origindb.waimai_order_shard__wm""";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
