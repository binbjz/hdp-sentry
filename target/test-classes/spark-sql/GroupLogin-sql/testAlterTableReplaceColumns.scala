val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE mart_waimai.test_replace_columns REPLACE COLUMNS (new_col1 INT COMMENT 'new column 1' , new_col2 STRING COMMENT 'new column 2')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE test_replace_columns";
spark.sql(test_sql).collect().foreach(println);

:q
