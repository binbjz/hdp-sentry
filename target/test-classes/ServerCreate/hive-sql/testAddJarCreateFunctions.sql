SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
ADD JAR ${hiveconf:FILEPATH}/hive_qa_udf.jar;
LIST JARS;
CREATE TEMPORARY FUNCTION tmp_qa_lower AS 'com.example.hive.udf.LowerCase';
CREATE FUNCTION qa_lower AS 'com.example.hive.udf.LowerCase';
SELECT qa_lower(name) as name FROM teacher;
SELECT tmp_qa_lower(name) as name FROM teacher;
SHOW FUNCTIONS LIKE '*qa_lower';
DROP FUNCTION qa_lower;

DELETE JAR ${hiveconf:FILEPATH}/hive_qa_udf.jar;