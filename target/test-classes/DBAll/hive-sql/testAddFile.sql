USE testdb;

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/who.txt' OVERWRITE INTO TABLE testdb.tble4addfile;
SET hive.cli.print.header=true;
SELECT * FROM testdb.tble4addfile;
ADD FILE ${hiveconf:FILEPATH}/test_who.sh;
LIST FILES;
SELECT TRANSFORM (who) USING 'sh test_who.sh' AS (who) FROM testdb.tble4addfile;
DELETE FILE ${hiveconf:FILEPATH}/test_who.sh;
LIST FILE;
