CREATE TABLE testdb.whoyouare(who string);
SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/who.txt' OVERWRITE INTO TABLE testdb.whoyouare;
SET hive.cli.print.header=true;
SELECT * FROM testdb.whoyouare;
<<<<<<< HEAD
ADD FILE ${hiveconf:FILEPATH}/test_who.sh;
LIST FILES;
SET hive.cli.print.header=true;
SELECT TRANSFORM (who) USING 'sh test_who.sh' AS (who) FROM testdb.whoyouare;
DELETE FILE ${hiveconf:FILEPATH}/test_who.sh;
=======
ADD FILE '${hiveconf:FILEPATH}/test_who.sh';
LIST FILES;
SET hive.cli.print.header=true;
SELECT TRANSFORM (who) USING 'sh test_who.sh' AS (who) FROM testdb.whoyouare;
DELETE FILE '${hiveconf:FILEPATH}/test_who.sh';
>>>>>>> b0450854b2f7ed1c2e1b2c8651afe9e2db333a37
LIST FILE;
DROP TABLE testdb.whoyouare;
