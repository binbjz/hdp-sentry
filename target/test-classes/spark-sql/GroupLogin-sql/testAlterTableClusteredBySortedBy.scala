val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE mart_waimai.employees_import_export CLUSTERED BY (name, address) SORTED BY (salary) INTO 48 BUCKETS";
spark.sql(test_sql).collect().foreach(println);

System.exit(0)
