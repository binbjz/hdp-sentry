USE default;

--SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/source-data;
--ADD FILE ${hiveconf:FILEPATH}/test_who.sh;
ADD FILE ${env:FILEPATH}/test_who.sh;
LIST FILES;
--DELETE FILE ${hiveconf:FILEPATH}/test_who.sh;
DELETE FILE ${env:FILEPATH}/test_who.sh;
LIST FILE;
