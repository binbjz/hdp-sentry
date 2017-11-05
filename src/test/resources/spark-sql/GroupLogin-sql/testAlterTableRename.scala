val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE test_rename RENAME TO test_rename_new";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE test_rename_new RENAME TO test_rename";
spark.sql(test_sql).collect().foreach(println);

val test_sql="USE dim";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE ndm_user RENAME TO ndm_user_new";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE ndm_user_new RENAME TO ndm_user";
spark.sql(test_sql).collect().foreach(println);

:q
