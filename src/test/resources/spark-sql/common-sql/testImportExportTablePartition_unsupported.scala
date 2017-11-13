val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

/* testImportExportPartition */
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

System.exit(0);
