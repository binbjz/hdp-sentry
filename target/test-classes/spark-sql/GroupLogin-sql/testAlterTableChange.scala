val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);

val test_sql='ALTER TABLE test_change CHANGE col1 col1to2 INT COMMENT "put column1 to position 2nd" AFTER col2';
spark.sql(test_sql).collect().foreach(println);
val test_sql='ALTER TABLE test_change CHANGE col3 col3to1 INT COMMENT "put last column to position 1st" FIRST';
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE test_change";
spark.sql(test_sql).collect().foreach(println);

:q
