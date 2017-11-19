val test_sql="USE dim";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/source-data";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ADD JAR ${hiveconf:FILEPATH}/hive_qa_udf.jar";
spark.sql(test_sql).collect().foreach(println);
val test_sql="LIST JARS";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE TEMPORARY FUNCTION tmp_qa_lower AS 'com.example.hive.udf.LowerCase'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE FUNCTION qa_lower AS 'com.example.hive.udf.LowerCase'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT tmp_qa_lower(username) as username FROM dim.ndm_user";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT qa_lower(username) as username FROM dim.ndm_user";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW FUNCTIONS LIKE '*qa_lower'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP FUNCTION qa_lower";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW FUNCTIONS LIKE '*qa_lower'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DELETE JAR ${hiveconf:FILEPATH}/hive_qa_udf.jar";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
