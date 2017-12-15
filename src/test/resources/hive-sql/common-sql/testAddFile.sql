USE testdb;

--SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/source-data;
SET hive.cli.print.header=true;
SELECT * FROM testdb.tbl4addfile;
--ADD FILE ${hiveconf:FILEPATH}/test_who.sh;
ADD FILE ${env:FILEPATH}/test_who.sh;
LIST FILES;
SET hive.cli.print.header=true;
SELECT TRANSFORM (who) USING 'sh test_who.sh' AS (who) FROM testdb.tbl4addfile;
--DELETE FILE ${hiveconf:FILEPATH}/test_who.sh;
DELETE FILE ${env:FILEPATH}/test_who.sh;
LIST FILE;
