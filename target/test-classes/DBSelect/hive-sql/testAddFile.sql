SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;

LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/who.txt' OVERWRITE INTO TABLE testdb.whoyouare;
SET hive.cli.print.header=true;
SELECT * FROM testdb.whoyouare;
ADD FILE ${hiveconf:FILEPATH}/test_who.sh;
LIST FILES;
SELECT TRANSFORM (who) USING 'sh test_who.sh' AS (who) FROM testdb.whoyouare;
DELETE FILE ${hiveconf:FILEPATH}/test_who.sh;
LIST FILE;
