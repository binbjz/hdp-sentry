//encrypt_db4data.whoyouare=who
//CREATE DATABASE encrypt_db4data
//DROP DATABASE encrypt_db4data

val test_sql="USE encrypt_db4data";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE TABLE encrypt_db4data.whoyouare(who string)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/source-data";
spark.sql(test_sql).collect().foreach(println);

val test_sql="LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/who.txt' OVERWRITE INTO TABLE encrypt_db4data.whoyouare";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM encrypt_db4data.whoyouare";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ADD FILE ${hiveconf:FILEPATH}/test_who.sh";
spark.sql(test_sql).collect().foreach(println);
val test_sql="LIST FILES";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT TRANSFORM (who) USING 'sh ${hiveconf:FILEPATH}/test_who.sh' AS (who) FROM encrypt_db4data.whoyouare";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DELETE FILE /opt/meituan/qa_test/testfile/test_who.sh";
spark.sql(test_sql).collect().foreach(println);
val test_sql="LIST FILE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE encrypt_db4data.whoyouare";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
