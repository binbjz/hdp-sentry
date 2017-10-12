USE db4add;
SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
ADD FILE ${hiveconf:FILEPATH}/test_who.sh;
LIST FILES;
DELETE FILE ${hiveconf:FILEPATH}/test_who.sh;
LIST FILE;
