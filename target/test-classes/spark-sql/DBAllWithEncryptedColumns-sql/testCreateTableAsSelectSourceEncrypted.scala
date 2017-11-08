--encrypt_db4data.session_src_encrypted=encrypt_page_url,encrypt_referrer_url
--CREATE DATABASE encrypt_db4data;
--DROP DATABASE encrypt_db4data;

val test_sql="USE encrypt_db4data";
spark.sql(test_sql).collect().foreach(println);
val test_sql="""CREATE TABLE encrypt_db4data.session_src_encrypted (
  user_id STRING
 ,pageview_id STRING
 ,encrypt_page_url STRING
 ,encrypt_referrer_url STRING
 ,timestamp DOUBLE)""";
spark.sql(test_sql).collect().foreach(println);
val test_sql="INSERT INTO encrypt_db4data.session_src_encrypted VALUES ('user001', 'pageview001', 'www.baidu.com', 'www.baidu.com/reference_url', 10001430), ('user002', 'pageview002', 'www.meituan.com', 'www.meituan.com/reference_url', 10001930)";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""CREATE TABLE encrypt_db4data.sessionization_step_one_origins
AS SELECT * FROM encrypt_db4data.session_src_encrypted""";

val test_sql="DROP TABLE encrypt_db4data.session_src_encrypted";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE encrypt_db4data.sessionization_step_one_origins";
spark.sql(test_sql).collect().foreach(println);

System.exit(0)
