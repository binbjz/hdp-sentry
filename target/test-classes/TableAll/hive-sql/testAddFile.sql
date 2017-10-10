--Execution:
SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;

LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/who.txt' OVERWRITE INTO TABLE testDB.whoyouare;
SET hive.cli.print.header=true;
SELECT * FROM testDB.whoyouare;
ADD FILE '${hiveconf:FILEPATH}/test_who.sh';
LIST FILES;
SET hive.cli.print.header=true;
SELECT TRANSFORM (who) USING 'sh test_who.sh' AS (who) FROM testDB.whoyouare;
DELETE FILE '${hiveconf:FILEPATH}/test_who.sh';
LIST FILE;
DROP TABLE testDB.whoyouare;

