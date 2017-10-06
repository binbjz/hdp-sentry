DROP DATABASE IF EXISTS db4add CASCADE;
CREATE DATABASE db4add;
CREATE TABLE db4add.whoyouare(who string);
LOAD DATA LOCAL INPATH '/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data/who.txt' OVERWRITE INTO TABLE db4add.whoyouare;
SET hive.cli.print.header=true;
SELECT * FROM db4add.whoyouare;
ADD FILE /opt/meituan/qa_test/testfile/test_who.sh;
LIST FILES;
SET hive.cli.print.header=true;
SELECT TRANSFORM (who) USING 'sh test_who.sh' AS (who) FROM db4add.whoyouare;
DELETE FILE /opt/meituan/qa_test/sentry-test/src/test/resources/hive-data/test_who.sh;
LIST FILE;
DROP TABLE db4add.whoyouare;
DROP DATABASE db4add;