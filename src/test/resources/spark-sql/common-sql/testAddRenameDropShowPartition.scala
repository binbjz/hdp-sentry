val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.tbl4partition ADD PARTITION (day=20110104)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.tbl4partition PARTITION (day=20110104) RENAME TO PARTITION (day=20110107)";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT id, part, quantity FROM testdb.tbl4partition WHERE day >= 20110102 AND day < 20110104 AND quantity < 4";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.tbl4partition PARTITION (day=20110102) RENAME TO PARTITION (day=20110109)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW PARTITIONS testdb.tbl4partition";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb.tbl4partition DROP PARTITION (day=20110103)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW PARTITIONS testdb.tbl4partition";
spark.sql(test_sql).collect().foreach(println);

:q




val test_sql="USE testdb_spark";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb_spark.tbl4partition ADD PARTITION (day=20110104)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb_spark.tbl4partition PARTITION (day=20110104) RENAME TO PARTITION (day=20110107)";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT id, part, quantity FROM testdb_spark.tbl4partition WHERE day >= 20110102 AND day < 20110104 AND quantity < 4";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb_spark.tbl4partition PARTITION (day=20110102) RENAME TO PARTITION (day=20110109)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW PARTITIONS testdb_spark.tbl4partition";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb_spark.tbl4partition DROP PARTITION (day=20110103)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW PARTITIONS testdb_spark.tbl4partition";
spark.sql(test_sql).collect().foreach(println);

:q
