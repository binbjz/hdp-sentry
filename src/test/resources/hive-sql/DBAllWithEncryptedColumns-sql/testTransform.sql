--encrypt_db4data.whoyouare=who
--CREATE DATABASE encrypt_db4data
--DROP DATABASE encrypt_db4data

USE encrypt_db4data;
CREATE TABLE encrypt_db4data.whoyouare(who string);
--SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/source-data;

--LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/who.txt' OVERWRITE INTO TABLE encrypt_db4data.whoyouare;
LOAD DATA LOCAL INPATH '${env:FILEPATH}/who.txt' OVERWRITE INTO TABLE encrypt_db4data.whoyouare;
SET hive.cli.print.header=true;
SELECT * FROM encrypt_db4data.whoyouare;
--ADD FILE ${hiveconf:FILEPATH}/test_who.sh;
ADD FILE ${env:FILEPATH}/test_who.sh;
LIST FILES;
--SELECT TRANSFORM (who) USING 'sh ${hiveconf:FILEPATH}/test_who.sh' AS (who) FROM encrypt_db4data.whoyouare;
SELECT TRANSFORM (who) USING 'sh ${env:FILEPATH}/test_who.sh' AS (who) FROM encrypt_db4data.whoyouare;
DELETE FILE /opt/meituan/qa_test/testfile/test_who.sh;
LIST FILE;
DROP TABLE encrypt_db4data.whoyouare;
