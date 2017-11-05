val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data";
spark.sql(test_sql).collect().foreach(println);

val test_sql="LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/test_file.txt'
INTO TABLE testdb.load_data_local_into_table";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT * FROM testdb.load_data_local_into_table";
spark.sql(test_sql).collect().foreach(println);

:q
