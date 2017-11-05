val test_sql="USE default";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ADD FILE ${hiveconf:FILEPATH}/test_who.sh";
spark.sql(test_sql).collect().foreach(println);

val test_sql="LIST FILES";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DELETE FILE ${hiveconf:FILEPATH}/test_who.sh";
spark.sql(test_sql).collect().foreach(println);

val test_sql="LIST FILE";
spark.sql(test_sql).collect().foreach(println);

:q