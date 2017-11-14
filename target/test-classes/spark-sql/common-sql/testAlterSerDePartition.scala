val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);


/*alter table serde partition*/

val test_sql="DESCRIBE EXTENDED testdb.test_serde_partition PARTITION (col10='abc', col20='123')";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb.test_serde_partition PARTITION (col10='abc', col20='123') SET SERDEPROPERTIES ('charset' = 'GBK', 'input.regex'='bduid\\[(.*)\\]uid\\[(\\d+)\\]', 'output.format.string' = '%1$s\t%2$s')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE EXTENDED testdb.test_serde_partition PARTITION (col10='abc', col20='123')";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
