val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""FROM testdb.src_test_insert_overwrite_tbl_partition se
INSERT OVERWRITE TABLE testdb.test_insert_overwrite_tbl_partition PARTITION (country = 'US', state = 'OR')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'OR'
INSERT OVERWRITE TABLE testdb.test_insert_overwrite_tbl_partition PARTITION (country = 'US', state = 'IL')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'IL'
INSERT OVERWRITE TABLE testdb.test_insert_overwrite_tbl_partition PARTITION (country = 'US', state = 'CA')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'CA'""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM testdb.test_insert_overwrite_tbl_partition";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""INSERT OVERWRITE TABLE testdb.test_insert_overwrite_tbl_partition PARTITION (country = 'US', state = 'CA')
SELECT name, salary, subordinates, deductions, address FROM testdb.src_test_insert_overwrite_tbl_partition se WHERE se.country = 'US' AND se.state = 'CA'""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="TRUNCATE TABLE testdb.test_insert_overwrite_tbl_partition";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""INSERT OVERWRITE TABLE testdb.test_insert_overwrite_tbl_partition PARTITION (country = 'US', state)
SELECT se.name, se.salary, se.subordinates, se.deductions, se.address, se.state FROM testdb.src_test_insert_overwrite_tbl_partition se WHERE se.country = 'US'""";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM testdb.test_insert_overwrite_tbl_partition";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
