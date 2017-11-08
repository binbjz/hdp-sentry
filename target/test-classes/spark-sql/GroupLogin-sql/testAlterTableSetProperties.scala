val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE test_rename SET TBLPROPERTIES ('notes' = 'Test for set tblproperties')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TBLPROPERTIES test_rename";
spark.sql(test_sql).collect().foreach(println);

val test_sql="USE dim";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE ndm_user SET TBLPROPERTIES ('notes' = 'Test for set tblproperties')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TBLPROPERTIES ndm_user";
spark.sql(test_sql).collect().foreach(println);

System.exit(0)
