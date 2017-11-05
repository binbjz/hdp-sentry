val test_sql="USE default";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.exec.dynamic.partition=true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.exec.dynamic.partition.mode=nonstrict";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT '${hiveconf:FILEPATH}' filepath";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT '${hiveconf:hive.cli.print.header}' printheader";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT '${hiveconf:hive.exec.dynamic.partition}' partition";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT '${hiveconf:hive.exec.dynamic.partition.mode}' partition_mode";
spark.sql(test_sql).collect().foreach(println);

:q
