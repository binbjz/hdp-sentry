//encrypt_db4alter.test_partition=encrypt_quantity
//CREATE DATABASE encrypt_db4alter;
//DROP DATABASE encrypt_db4alter;


//encrypt_db4func.teacher=name
//CREATE DATABASE encrypt_db4func;
//DROP DATABASE encrypt_db4func;
//encrypt_db4data.whoyouare=who
//CREATE DATABASE encrypt_db4data
//DROP DATABASE encrypt_db4data


val test_sql = "SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);
//val test_sql="SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/source-data";
//spark.sql(test_sql).collect().foreach(println);

/* test AddJarCreateFuncAndTmpFunc */
//encrypt_db4func.teacher=name
//CREATE DATABASE encrypt_db4func;
//DROP DATABASE encrypt_db4func;

val test_sql = "USE encrypt_db4func";
spark.sql(test_sql).collect().foreach(println);

val test_sql = "ADD JAR ${env:FILEPATH}/hive_qa_udf.jar";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "LIST JARS";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "CREATE FUNCTION qa_lower AS 'com.example.hive.udf.LowerCase'";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "CREATE TEMPORARY FUNCTION tmp_qa_lower AS 'com.example.hive.udf.LowerCase'";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "CREATE TABLE teacher (name STRING)";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "INSERT INTO teacher VALUES ('TEACHER QA')";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "SELECT * FROM teacher";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "SELECT qa_lower(name) as name FROM teacher";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "SELECT tmp_qa_lower(name) as name  FROM teacher";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "SHOW FUNCTIONS LIKE '*qa_lower'";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "DROP FUNCTION qa_lower";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "SHOW FUNCTIONS LIKE '*qa_lower'";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "DROP TABLE teacher";
spark.sql(test_sql).collect().foreach(println);

/*https://issues.apache.org/jira/browse/SPARK-15763
Currently Spark support "Add File/Jar <filepath|jarpath>" in SPARK SQL, but not "Delete File/Jar <filepath|jarpath>*/
val test_sql = "DELETE JAR hive_qa_udf.jar";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "LIST JARS";
spark.sql(test_sql).collect().foreach(println);

/* test Add File */
//encrypt_db4data.whoyouare=who
//CREATE DATABASE encrypt_db4data
//DROP DATABASE encrypt_db4data

val test_sql = "USE encrypt_db4data";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "CREATE TABLE encrypt_db4data.whoyouare(who string)";
spark.sql(test_sql).collect().foreach(println);

val test_sql = "LOAD DATA LOCAL INPATH '${env:FILEPATH}/who.txt' OVERWRITE INTO TABLE encrypt_db4data.whoyouare";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "SELECT * FROM encrypt_db4data.whoyouare";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "ADD FILE ${env:FILEPATH}/test_who.sh";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "LIST FILES";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "SELECT TRANSFORM (who) USING 'sh test_who.sh' AS (who) FROM encrypt_db4data.whoyouare";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "DELETE FILE ${env:FILEPATH}/test_who.sh";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "LIST FILE";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "DROP TABLE encrypt_db4data.whoyouare";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
