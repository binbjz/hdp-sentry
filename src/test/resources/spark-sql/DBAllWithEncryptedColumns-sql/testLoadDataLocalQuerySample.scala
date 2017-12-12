//encrypt_db4data.collecttest=str
//CREATE DATABASE encrypt_db4data;
//DROP DATABASE encrypt_db4data;

val test_sql="USE encrypt_db4data";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""CREATE TABLE encrypt_db4data.collecttest (str STRING, countval INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '&' LINES TERMINATED BY '\n'""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/source-data";
spark.sql(test_sql).collect().foreach(println);
val test_sql="LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/test_file.txt' INTO TABLE encrypt_db4data.collecttest";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT concat_ws( ',' , collect_set(cast(countval AS STRING))) FROM encrypt_db4data.collecttest";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT countval, concat_ws( ',' , collect_set(cast(str AS STRING))) FROM encrypt_db4data.collecttest GROUP BY countval";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT str, count(*) as val FROM encrypt_db4data.collecttest GROUP BY str";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT countval, count(*) as val FROM encrypt_db4data.collecttest GROUP BY countval";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT count(*) FROM encrypt_db4data.collecttest";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT * FROM encrypt_db4data.collecttest TABLESAMPLE(100.0 PERCENT) s";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT * FROM encrypt_db4data.collecttest TABLESAMPLE(2 ROWS) s";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE encrypt_db4data.collecttest";
spark.sql(test_sql).collect().foreach(println);

/*
dfs -cat /user/hive/warehouse/encrypt_db4data.db/collecttest/test_file.txt;
dfs -copyToLocal /user/hive/warehouse/encrypt_db4data.db/collecttest/test_file.txt /tmp;
!cat /tmp/test_file.txt;
!rm /tmp/test_file.txt;*/

System.exit(0);
