val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

/*alter table serde partition*/

val test_sql="DESCRIBE EXTENDED testdb.test_serde_partition PARTITION (col10='abc', col20='123')";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb.test_serde_partition PARTITION (col10='abc', col20='123') SET SERDEPROPERTIES ('charset' = 'GBK', 'input.regex'='bduid\\[(.*)\\]uid\\[(\\d+)\\]', 'output.format.string' = '%1$s\t%2$s')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE EXTENDED testdb.test_serde_partition PARTITION (col10='abc', col20='123')";
spark.sql(test_sql).collect().foreach(println);


/*alter table touch partition*/

val test_sql="ALTER TABLE tbl4analyze TOUCH PARTITION (country = 'US', state = 'CA')";
spark.sql(test_sql).collect().foreach(println);

:q



val test_sql="USE testdb_spark";
spark.sql(test_sql).collect().foreach(println);

/*alter table serde partition*/

val test_sql="DESCRIBE EXTENDED testdb_spark.test_serde_partition PARTITION (col10='abc', col20='123')";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb_spark.test_serde_partition PARTITION (col10='abc', col20='123') SET SERDEPROPERTIES ('charset' = 'GBK', 'input.regex'='bduid\\[(.*)\\]uid\\[(\\d+)\\]', 'output.format.string' = '%1$s\t%2$s')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE EXTENDED testdb_spark.test_serde_partition PARTITION (col10='abc', col20='123')";
spark.sql(test_sql).collect().foreach(println);


/*alter table touch partition*/

val test_sql="ALTER TABLE tbl4analyze TOUCH PARTITION (country = 'US', state = 'CA')";
spark.sql(test_sql).collect().foreach(println);

:q

