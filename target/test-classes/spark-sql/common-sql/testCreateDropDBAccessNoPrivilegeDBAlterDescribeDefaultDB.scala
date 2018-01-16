val test_sql="USE default";
spark.sql(test_sql).collect().foreach(println);


/*Create DB*/

val test_sql="CREATE DATABASE db4create LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/db4create.db' WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE db4create_no_privilege LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/db4create_no_privilege.db' WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW DATABASES LIKE 'db4create*'";
spark.sql(test_sql).collect().foreach(println);


/*Drop DB*/

val test_sql="DROP DATABASE db4drop";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW DATABASES LIKE 'db4drop'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP DATABASE db4drop_cascade";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW DATABASES LIKE 'db4drop*'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP DATABASE db4drop_cascade CASCADE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW DATABASES LIKE 'db4drop*'";
spark.sql(test_sql).collect().foreach(println);


/* test AccessNoPrivilegeDB*/

val test_sql="SHOW DATABASES LIKE 'unaccessibledb'";
spark.sql(test_sql).collect().foreach(println);


/* testAlterDescribeDefaultDB */

val test_sql="ALTER DATABASE default SET DBPROPERTIES ('edited-by' = 'hadoop-new-qa')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE DATABASE EXTENDED default";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
