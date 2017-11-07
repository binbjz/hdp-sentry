val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE testdb.load_data_local_into_partition
PARTITION (country = 'US', state = 'CA')""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT * FROM testdb.load_data_local_into_partition";
spark.sql(test_sql).collect().foreach(println);

:q


val test_sql="USE testdb_spark";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE testdb_spark.load_data_local_into_partition
PARTITION (country = 'US', state = 'CA')""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT * FROM testdb_spark.load_data_local_into_partition";
spark.sql(test_sql).collect().foreach(println);

:q

