val test_sql="USE default";
spark.sql(test_sql).collect().foreach(println);

val test_sql="CREATE DATABASE db4create LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/db4create.db' WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE db4create_no_privilege LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/db4create_no_privilege.db' WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW DATABASES LIKE 'db4create*'";
spark.sql(test_sql).collect().foreach(println);

:q





val test_sql="USE default";
spark.sql(test_sql).collect().foreach(println);

val test_sql="CREATE DATABASE db4create_spark LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/db4create_spark.db' WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE db4create_no_privilege_spark LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/db4create_no_privilege_spark.db' WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW DATABASES LIKE 'db4create*'";
spark.sql(test_sql).collect().foreach(println);

:q

