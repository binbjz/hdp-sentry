val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="EXPORT TABLE testdb.src_import_export PARTITION (country = 'US', state = 'CA') TO '/tmp/import_export_partition'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM testdb.src_import_export";
spark.sql(test_sql).collect().foreach(println);

val test_sql="IMPORT TABLE testdb.import_export PARTITION (country = 'US', state = 'CA') FROM '/tmp/import_export_partition'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW PARTITIONS testdb.import_export";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM testdb.import_export";
spark.sql(test_sql).collect().foreach(println);




val test_sql="USE testdb_spark";
spark.sql(test_sql).collect().foreach(println);

val test_sql="EXPORT TABLE testdb_spark.src_import_export PARTITION (country = 'US', state = 'CA') TO '/tmp/import_export_partition'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM testdb_spark.src_import_export";
spark.sql(test_sql).collect().foreach(println);

val test_sql="IMPORT TABLE testdb_spark.import_export PARTITION (country = 'US', state = 'CA') FROM '/tmp/import_export_partition'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW PARTITIONS testdb_spark.import_export";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM testdb_spark.import_export";
spark.sql(test_sql).collect().foreach(println);

