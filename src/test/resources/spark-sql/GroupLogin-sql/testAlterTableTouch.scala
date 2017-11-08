val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE mart_waimai.employees_import_export TOUCH";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE mart_waimai.src_employees_import_export TOUCH PARTITION (country='US', state='CA')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE mart_waimai.employees_import_export TOUCH PARTITION (country='US', state='CA')";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DESCRIBE mart_waimai.employees_import_export PARTITION (country='US', state='CA')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE EXTENDED mart_waimai.employees_import_export PARTITION (country='US', state='CA')";
spark.sql(test_sql).collect().foreach(println);

System.exit(0)
