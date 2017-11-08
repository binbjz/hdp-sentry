val test_sql="USE default";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data";
spark.sql(test_sql).collect().foreach(println);


/* add jar create func and tmp func without table */

val test_sql="ADD JAR ${hiveconf:FILEPATH}/hive_qa_udf.jar";
spark.sql(test_sql).collect().foreach(println);
val test_sql="LIST JARS";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE TEMPORARY FUNCTION tmp_qa_lower AS 'com.example.hive.udf.LowerCase'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE FUNCTION qa_lower AS 'com.example.hive.udf.LowerCase'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DELETE JAR ${hiveconf:FILEPATH}/hive_qa_udf.jar";
spark.sql(test_sql).collect().foreach(println);
val test_sql="LIST JARS";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW FUNCTIONS LIKE '*qa_lower'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP FUNCTION qa_lower";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW FUNCTIONS LIKE '*qa_lower'";
spark.sql(test_sql).collect().foreach(println);


/* add file without table */

val test_sql="ADD FILE ${hiveconf:FILEPATH}/test_who.sh";
spark.sql(test_sql).collect().foreach(println);

val test_sql="LIST FILES";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DELETE FILE ${hiveconf:FILEPATH}/test_who.sh";
spark.sql(test_sql).collect().foreach(println);

val test_sql="LIST FILE";
spark.sql(test_sql).collect().foreach(println);

System.exit(0)
