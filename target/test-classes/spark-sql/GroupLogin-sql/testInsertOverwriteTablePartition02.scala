val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""FROM mart_waimai.src_employees_insert_overwrite se
INSERT OVERWRITE TABLE mart_waimai.employees_insert_overwrite PARTITION (country = 'US', state = 'OR')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'OR'
INSERT OVERWRITE TABLE mart_waimai.employees_insert_overwrite PARTITION (country = 'US', state = 'IL')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'IL'
INSERT OVERWRITE TABLE mart_waimai.employees_insert_overwrite PARTITION (country = 'US', state = 'CA')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'CA'""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM mart_waimai.employees_insert_overwrite";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""INSERT OVERWRITE TABLE mart_waimai.employees_insert_overwrite PARTITION (country = 'US', state = 'CA')
SELECT name, salary, subordinates, deductions, address FROM mart_waimai.src_employees_insert_overwrite se WHERE se.country = 'US' AND se.state = 'CA'""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="TRUNCATE TABLE mart_waimai.employees_insert_overwrite";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET hive.exec.dynamic.partition=true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.vectorized.execution.enabled = true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.vectorized.execution.reduce.enabled = true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="""INSERT OVERWRITE TABLE mart_waimai.employees_insert_overwrite PARTITION (country = 'US', state)
SELECT se.name, se.salary, se.subordinates, se.deductions, se.address, se.state FROM mart_waimai.src_employees_insert_overwrite se WHERE se.country = 'US'""";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM mart_waimai.employees_insert_overwrite";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
