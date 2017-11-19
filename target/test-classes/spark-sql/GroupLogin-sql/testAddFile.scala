val test_sql="USE dim";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/source-data";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT username FROM dim.ndm_user";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ADD FILE ${hiveconf:FILEPATH}/test_who.sh";
spark.sql(test_sql).collect().foreach(println);
val test_sql="LIST FILES";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT TRANSFORM (username) USING 'sh test_who.sh' AS (username) FROM dim.ndm_user";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DELETE FILE ${hiveconf:FILEPATH}/test_who.sh";
spark.sql(test_sql).collect().foreach(println);
val test_sql="LIST FILE";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
