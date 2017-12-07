val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/source-data";
spark.sql(test_sql).collect().foreach(println);

val test_sql="LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/test_file.txt' INTO TABLE collecttest";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT str, concat_ws( ',' , collect_set(cast(countval AS STRING))) FROM collecttest GROUP BY str";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT str, count(*) as val FROM collecttest GROUP BY str";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT count(*) FROM collecttest";
spark.sql(test_sql).collect().foreach(println);

val test_sql="USE dim";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT str, concat_ws( ',' , collect_set(cast(countval AS STRING))) FROM collecttest GROUP BY str";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT str, count(*) as val FROM collecttest GROUP BY str";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT count(*) FROM collecttest";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
