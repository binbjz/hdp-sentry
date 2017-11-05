val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb.tbl4fileformat PARTITION (year=2012, month=1, day=1) SET FILEFORMAT SEQUENCEFILE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE EXTENDED testdb.tbl4fileformat PARTITION (year=2012, month=1, day=1)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.tbl4fileformat SET FILEFORMAT SEQUENCEFILE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE EXTENDED testdb.tbl4fileformat";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb.tbl4fileformat_external PARTITION (year=2012, month=1, day=1) SET FILEFORMAT SEQUENCEFILE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE EXTENDED testdb.tbl4fileformat_external PARTITION (year=2012, month=1, day=1)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.tbl4fileformat_external SET FILEFORMAT SEQUENCEFILE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE EXTENDED testdb.tbl4fileformat_external";
spark.sql(test_sql).collect().foreach(println);

:q
