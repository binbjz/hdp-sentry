SET hive.cli.print.header=true;
SELECT * FROM test_db.whoyouare;
ADD FILE /opt/meituan/qa_test/sentry-test/src/test/resources/hive-data/test_who.sh;
LIST FILES;
SET hive.cli.print.header=true;
SELECT TRANSFORM (who) USING 'sh test_who.sh' AS (who) FROM test_db.whoyouare;
DELETE FILE /opt/meituan/qa_test/sentry-test/src/test/resources/hive-data/test_who.sh;
LIST FILE;
