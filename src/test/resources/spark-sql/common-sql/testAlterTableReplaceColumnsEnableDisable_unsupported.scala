val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

/* test Alter Table Replace Columns*/

val test_sql="ALTER TABLE tbl4replacecolumns REPLACE COLUMNS (new_col1 INT COMMENT 'new column 1')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE tbl4replacecolumns";
spark.sql(test_sql).collect().foreach(println);


/* test Alter Table Enable Disable */

val test_sql="ALTER TABLE testdb.test_enable_disable1 ENABLE NO_DROP";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.test_enable_disable1";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.test_enable_disable1 DISABLE NO_DROP";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.test_enable_disable1";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb.test_enable_disable2 ENABLE OFFLINE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.test_enable_disable2";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.test_enable_disable2 DISABLE OFFLINE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.test_enable_disable2";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
