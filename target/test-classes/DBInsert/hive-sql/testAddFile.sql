USE db4addfile;

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/who.txt' OVERWRITE INTO TABLE db4addfile.tbl4addfile;
SET hive.cli.print.header=true;
SELECT * FROM db4addfile.tbl4addfile;
ADD FILE ${hiveconf:FILEPATH}/test_who.sh;
LIST FILES;

SET hive.cli.print.header=true;
SELECT TRANSFORM (who) USING 'sh ${hiveconf:FILEPATH}/test_who.sh' AS (who) FROM db4addfile.tbl4addfile;
DELETE FILE ${hiveconf:FILEPATH}/test_who.sh;
LIST FILE;
