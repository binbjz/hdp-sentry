val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb.tbl4analyze CLUSTERED BY (name, address) SORTED BY (salary) INTO 48 BUCKETS";
spark.sql(test_sql).collect().foreach(println);

:q




val test_sql="USE testdb_spark";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb.tbl4analyze CLUSTERED BY (name, address) SORTED BY (salary) INTO 48 BUCKETS";
spark.sql(test_sql).collect().foreach(println);

:q

