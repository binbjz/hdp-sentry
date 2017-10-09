CREATE DATABASE db4addfile;
CREATE TABLE db4addfile.whoyouare(who string);

--Execution:
set FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/who.txt' OVERWRITE INTO TABLE db4addfile.whoyouare;
SET hive.cli.print.header=true;
SELECT * FROM db4addfile.whoyouare;
ADD FILE /opt/meituan/qa_test/testfile/test_who.sh;
LIST FILES;

SET hive.cli.print.header=true;
SELECT TRANSFORM (who) USING 'sh ${hiveconf:FILEPATH}/test_who.sh' AS (who) FROM db4addfile.whoyouare;
DELETE FILE /opt/meituan/qa_test/testfile/test_who.sh;
LIST FILE;

--Cleanup:
DROP TABLE db4addfile.whoyouare;
DROP DATABASE db4addfile;