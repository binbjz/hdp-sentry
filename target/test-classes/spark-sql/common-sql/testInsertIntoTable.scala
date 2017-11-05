val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT INTO testdb.src_insert_overwrite_tbl VALUES ('alibaba', '10.0.0.3')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM testdb.src_insert_overwrite_tbl WHERE name = 'alibaba'";
spark.sql(test_sql).collect().foreach(println);

:q
