val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT OVERWRITE TABLE testdb.insert_overwrite_tbl SELECT name, ip FROM testdb.src_insert_overwrite_tbl WHERE name='meituan'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM testdb.insert_overwrite_tbl";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT OVERWRITE TABLE testdb.insert_overwrite_tbl SELECT * FROM testdb.src_insert_overwrite_tbl";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM testdb.insert_overwrite_tbl";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT ROW_NUMBER() OVER(PARTITION BY ip ORDER BY ip DESC) ID, name, ip FROM testdb.src_insert_overwrite_tbl";
spark.sql(test_sql).collect().foreach(println);

:q




val test_sql="USE testdb_spark";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT OVERWRITE TABLE testdb_spark.insert_overwrite_tbl SELECT name, ip FROM testdb.src_insert_overwrite_tbl WHERE name='meituan'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM testdb_spark.insert_overwrite_tbl";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT OVERWRITE TABLE testdb_spark.insert_overwrite_tbl SELECT * FROM testdb.src_insert_overwrite_tbl";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM testdb_spark.insert_overwrite_tbl";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT ROW_NUMBER() OVER(PARTITION BY ip ORDER BY ip DESC) ID, name, ip FROM testdb_spark.src_insert_overwrite_tbl";
spark.sql(test_sql).collect().foreach(println);

:q
