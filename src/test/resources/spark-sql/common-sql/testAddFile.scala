val test_sql="USE testdb";
spark.sql(test_sql).show();

val test_sql="SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data";
spark.sql(test_sql).show();

val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).show();

val test_sql="SELECT * FROM testdb.tbl4addfile";
spark.sql(test_sql).show();

val test_sql="ADD FILE ${hiveconf:FILEPATH}/test_who.sh";
spark.sql(test_sql).show();

val test_sql="LIST FILES";
spark.sql(test_sql).show();

val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).show();

val test_sql="SELECT TRANSFORM (who) USING 'sh test_who.sh' AS (who) FROM testdb.tbl4addfile";
spark.sql(test_sql).show();

val test_sql="DELETE FILE ${hiveconf:FILEPATH}/test_who.sh";
spark.sql(test_sql).show();

val test_sql="LIST FILE";
spark.sql(test_sql).show();

:q
