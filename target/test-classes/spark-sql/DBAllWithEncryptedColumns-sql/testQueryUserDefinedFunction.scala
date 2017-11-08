--encrypt_db4func.teacher=name
--CREATE DATABASE encrypt_db4func;
--DROP DATABASE encrypt_db4func;

val test_sql="USE encrypt_db4func";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ADD JAR  ${hiveconf:FILEPATH}/hive_qa_udf.jar";
spark.sql(test_sql).collect().foreach(println);
val test_sql="LIST JARS";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE FUNCTION qa_lower AS 'com.example.hive.udf.LowerCase'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE TEMPORARY FUNCTION tmp_qa_lower AS 'com.example.hive.udf.LowerCase'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE TABLE teacher (name STRING)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="INSERT INTO teacher VALUES ('TEACHER QA')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM teacher";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT qa_lower(name) as name FROM teacher";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT tmp_qa_lower(name) as name  FROM teacher";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW FUNCTIONS LIKE '*qa_lower'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE teacher";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DELETE JAR ${hiveconf:FILEPATH}/hive_qa_udf.jar";
spark.sql(test_sql).collect().foreach(println);

System.exit(0)
