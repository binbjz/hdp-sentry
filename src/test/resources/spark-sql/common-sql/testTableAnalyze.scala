val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ANALYZE TABLE testdb.tbl4analyze COMPUTE STATISTICS FOR columns name, salary";
spark.sql(test_sql).collect().foreach(println);

/* 只搜集分区*/

val test_sql="ANALYZE TABLE testdb.tbl4analyze PARTITION (country = 'US', state = 'CA') COMPUTE STATISTICS";
spark.sql(test_sql).collect().foreach(println);

/* 如果执行,则同时搜集分区间OR/CA/IL*/

val test_sql="ANALYZE TABLE testdb.tbl4analyze PARTITION (country = 'US', state)  COMPUTE STATISTICS";
spark.sql(test_sql).collect().foreach(println);

/* 如果执行 搜集所有分区*/

val test_sql="ANALYZE TABLE testdb.tbl4analyze PARTITION (country, state) COMPUTE STATISTICS";
spark.sql(test_sql).collect().foreach(println);

/* 查看分区的统计信息*/

val test_sql="DESCRIBE EXTENDED testdb.tbl4analyze";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DESCRIBE EXTENDED testdb.tbl4analyze PARTITION (country = 'US', state = 'CA')";
spark.sql(test_sql).collect().foreach(println);

:q
