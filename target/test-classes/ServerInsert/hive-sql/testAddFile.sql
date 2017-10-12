SET hive.cli.print.header=true;
SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
SELECT * FROM testdb.whoyouare;
ADD FILE ${hiveconf:FILEPATH}/test_who.sh;
LIST FILES;
SET hive.cli.print.header=true;
SELECT TRANSFORM (who) USING 'sh test_who.sh' AS (who) FROM testdb.whoyouare;
DELETE FILE ${hiveconf:FILEPATH}/test_who.sh;
LIST FILE;
