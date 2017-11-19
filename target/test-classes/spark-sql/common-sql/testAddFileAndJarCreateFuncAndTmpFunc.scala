val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);

/* test AddJarCreateFuncAndTmpFunc */


val test_sql="ADD JAR hive_qa_udf.jar";
spark.sql(test_sql).collect().foreach(println);

val test_sql="LIST JARS";
spark.sql(test_sql).collect().foreach(println);

val test_sql="CREATE TEMPORARY FUNCTION tmp_qa_lower AS 'com.example.hive.udf.LowerCase'";
spark.sql(test_sql).collect().foreach(println);

val test_sql="CREATE FUNCTION qa_lower AS 'com.example.hive.udf.LowerCase'";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT tmp_qa_lower(name) as name FROM tbl4jarfile";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT qa_lower(name) as name FROM tbl4jarfile";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SHOW FUNCTIONS LIKE '*qa_lower'";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP FUNCTION qa_lower";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SHOW FUNCTIONS LIKE '*qa_lower'";
spark.sql(test_sql).collect().foreach(println);

/*https://issues.apache.org/jira/browse/SPARK-15763
Currently Spark support "Add File/Jar <filepath|jarpath>" in SPARK SQL, but not "Delete File/Jar <filepath|jarpath>*/
val test_sql="DELETE JAR hive_qa_udf.jar";
spark.sql(test_sql).collect().foreach(println);

val test_sql="LIST JARS";
spark.sql(test_sql).collect().foreach(println);


/* test Add File */

val test_sql="SELECT * FROM testdb.tbl4addfile";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/source-data";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ADD FILE ${hiveconf:FILEPATH}/test_who.sh";
spark.sql(test_sql).collect().foreach(println);

val test_sql="LIST FILES";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT TRANSFORM (who) USING 'sh test_who.sh' AS (who) FROM testdb.tbl4addfile";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DELETE FILE ${hiveconf:FILEPATH}/test_who.sh";
spark.sql(test_sql).collect().foreach(println);

val test_sql="LIST FILE";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
