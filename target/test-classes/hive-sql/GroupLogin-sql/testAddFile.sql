USE dim;

--SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/source-data;

SET hive.cli.print.header=true;
SELECT username FROM dim.ndm_user;
--ADD FILE ${hiveconf:FILEPATH}/test_who.sh;
ADD FILE ${env:FILEPATH}/test_who.sh;
LIST FILES;
SELECT TRANSFORM (username) USING 'sh test_who.sh' AS (username) FROM dim.ndm_user;
--DELETE FILE ${hiveconf:FILEPATH}/test_who.sh;
DELETE FILE ${env:FILEPATH}/test_who.sh;
LIST FILE;
