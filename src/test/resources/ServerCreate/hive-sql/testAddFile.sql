SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;

CREATE TABLE whoyouare(who string);
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/who.txt' OVERWRITE INTO TABLE whoyouare;
ADD FILE ${hiveconf:FILEPATH}/test_who.sh;
LIST FILES;
SET hive.cli.print.header=true;
SELECT TRANSFORM (who) USING 'sh test_who.sh' AS (who) FROM whoyouare;
DELETE FILE ${hiveconf:FILEPATH}/test_who.sh;
LIST FILE;
