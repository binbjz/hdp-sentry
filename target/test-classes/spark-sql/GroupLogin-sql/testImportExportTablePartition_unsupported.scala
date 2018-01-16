val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);

/* 导出分区并且导入到分区表分区 */
val test_sql="EXPORT TABLE mart_waimai.src_employees_import_export PARTITION (country = 'US', state = 'CA') TO '/tmp/employee'";
spark.sql(test_sql).collect().foreach(println);

val test_sql="IMPORT TABLE mart_waimai.employees_import_export PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW PARTITIONS mart_waimai.employees_import_export";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
