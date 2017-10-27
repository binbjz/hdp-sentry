--DROP DATABASE IF EXISTS db4add CASCADE;
--CREATE DATABASE db4add;
--CREATE TABLE db4add.tbl4addfile(who STRING);

--DROP TABLE db4add.tbl4addfile;
--DROP DATABASE db4add;

USE db4add;
SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/who.txt' OVERWRITE INTO TABLE db4add.tbl4addfile;
SET hive.cli.print.header=true;
SELECT * FROM db4add.tbl4addfile;
ADD FILE ${hiveconf:FILEPATH}/test_who.sh;
LIST FILES;
SET hive.cli.print.header=true;
SELECT TRANSFORM (who) USING 'sh test_who.sh' AS (who) FROM db4add.tbl4addfile;
DELETE FILE ${hiveconf:FILEPATH}/test_who.sh;
LIST FILE;
